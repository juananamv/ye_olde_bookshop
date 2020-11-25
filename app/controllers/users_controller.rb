class UsersController < ApplicationController
  def my_orders
    if user_signed_in?
      @user = User.find(current_user.id)
      @orders = @user.orders
    else
      flash.alert = "Please log in or register"
      redirect_to root_path
    end
  end
end
