class UsersController < ApplicationController
  def my_orders
    if user_signed_in?
      @orders = User.find(current_user.id).orders
    else
      flash.alert = "Please log in or register"
      redirect_to root_path
    end
  end
end
