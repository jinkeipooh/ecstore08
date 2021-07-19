class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_cart
    if session[:cart_id]
      current_cart = Cart.find_by(id: session[:cart_id])
      session[:cart_id] = current_cart.id
      current_cart
    else
      if user_signed_in?
        current_cart = Cart.create(user_id: current_user.id)        ###  current_user → ログインしていないユーザーが入れない！
        session[:cart_id] = current_cart.id
        current_cart = Cart.find_by(id: session[:cart_id])
        current_cart
      else
        render :index                                               ###  renderで引き戻しているが、、これで良いのか？？？？？？？？？
      end
    end
  end
  

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :birthday])
  end
end
