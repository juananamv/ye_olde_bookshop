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
end
