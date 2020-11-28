class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password, :password_confirmation, :province_id, :address, :city, :postal_code)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:email, :password, :current_password, :province_id, :address, :city, :postal_code)
    end
   end

  private

  def initialize_session
    session[:cart] ||= {}
  end

  def load_cart
    array = session[:cart].keys
    @cart = Product.find(array)
  end
end
