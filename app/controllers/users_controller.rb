class UsersController < ApplicationController
  def my_orders
    @user = User.find(current_user.id)
  end
end
