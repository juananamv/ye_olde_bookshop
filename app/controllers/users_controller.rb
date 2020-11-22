class UsersController < ApplicationController
  def my_orders
    @orders = User.find(current_user.id).orders
  end
end
