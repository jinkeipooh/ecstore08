class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_cart
    if session[:cart_id]
      current_cart = Cart.find_by(id: session[:cart_id])
      session[:cart_id] = current_cart.id
      current_cart
    else
      current_cart = Cart.create(user_id: current_user.id)
      session[:cart_id] = current_cart.id
      current_cart = Cart.find_by(id: session[:cart_id])
      current_cart
    end
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :birthday])
  end
end
