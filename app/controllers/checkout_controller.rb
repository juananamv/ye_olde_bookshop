class CheckoutController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to root_path
      flash.alert = "Please Log in to be able to checkout"
    else
      @user = User.find(current_user.id)
      @shopping_cart = session[:cart]
      @subtotal = 0
      @products = []

      @shopping_cart.each do |id, qty|
        product = Product.find(id.to_s)
        @products << product
        @subtotal += product.price * qty
      end

      @gst = (@subtotal * @user.province.gst).round(2)
      @pst = (@subtotal * @user.province.pst).round(2)
      @total = @subtotal + @gst + @pst
    end
  end

  def submit
    cart = JSON.parse(params["cart"].gsub("=>", ":"))
    user = User.find(current_user.id)

    new_order = user.orders.create(
      status: "Awaiting Payment",
      date:   DateTime.now,
      gst:    params["gst"].to_d.round(2),
      pst:    params["pst"].to_d.round(2)
    )

    cart.each do |item, qty|
      prod_ref = Product.find(item.to_i)
      prod_ref.quantity -= qty.to_i
      prod_ref.save
      new_order.order_items.create(
        product_name: prod_ref.name.to_s,
        count:        qty.to_i,
        subtotal:     (prod_ref.price * qty.to_i)
      )
    end

    session.delete(:cart)
    flash.alert = new_order.status.to_s
    redirect_to root_path
  end
end
