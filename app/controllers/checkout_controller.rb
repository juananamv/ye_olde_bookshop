class CheckoutController < ApplicationController
  before_action :initialize_session
  before_action :load_cart

  def index
    if !user_signed_in?
      redirect_to root_path
      flash.alert = "Please Log in to be able to checkout"
    else
      @user = User.find(current_user.id)
      @shopping_cart = session[:cart]
      @subtotal = 0
      @products = []

      @shopping_cart&.each do |id, qty|
        product = Product.find(id.to_s)
        @products << product
        @subtotal += product.price * qty
      end

      @gst = (@subtotal * @user.province.gst).round(2)
      @pst = (@subtotal * @user.province.pst).round(2)
      @total = @subtotal + @gst + @pst
    end
  end

  def create
    # Load cart info
    cart = JSON.parse(params["cart"].gsub("=>", ":"))

    if cart.empty?
      redirect_to root_path
      flash.alert = "Your cart is empty"
      return
    end

    # Save Order information to DB
    line_items_array = [
      {
        name:        "GST/HST",
        description: "Goods and Services/Harmonized Sales Tax",
        amount:      (params["gst"].to_d.round(2) * 100).to_i,
        currency:    "cad",
        quantity:    1
      }
    ]

    unless params["pst"].to_d.zero?
      line_items_array << {
        name:        "PST",
        description: "Provincial Sales Tax",
        amount:      (params["pst"].to_d.round(2) * 100).to_i,
        currency:    "cad",
        quantity:    1
      }
    end

    user = User.find(current_user.id)

    new_order = user.orders.create(
      status: "Awaiting Payment",
      date:   DateTime.now,
      gst:    params["gst"].to_d.round(2),
      pst:    params["pst"].to_d.round(2)
    )

    cart.each do |item, qty|
      # Find and update quantity
      prod_ref = Product.find(item.to_i)
      prod_ref.quantity -= qty.to_i
      prod_ref.save

      # Create hash entry in line items array
      line_items_array << {
        name:        prod_ref.name,
        description: prod_ref.description,
        amount:      (prod_ref.price * 100).to_i,
        currency:    "cad",
        quantity:    qty
      }

      # Create associated order item entry
      new_order.order_items.create(
        product_name: prod_ref.name.to_s,
        product_id:   prod_ref.id.to_i,
        count:        qty.to_i,
        subtotal:     (prod_ref.price * qty.to_i)
      )
    end

    # Connection with Stripe
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url + "?session_id={CHECKOUT_SESSION_ID}",
      line_items:           line_items_array
    )

    new_order.stripe_session = @session.id
    new_order.save

    respond_to do |format|
      format.js
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @order = Order.find_by(stripe_session: params[:session_id])

    if @payment_intent.charges.data[0].amount_captured == (@order.total * 100).to_i && @payment_intent.charges.data[0].paid
      @order.status = "Payment Received"
      @order.save
    end

    session.delete(:cart)
  end

  def cancel
    @order = Order.find_by(stripe_session: params[:session_id])
    unless @order.nil?
      @order.order_items&.each do |item|
        product_ref = Product.find(item.product_id)
        product_ref.quantity += item.count
        product_ref.save
      end
      @order.destroy
    end
  end
end
