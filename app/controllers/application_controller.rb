class ApplicationController < ActionController::Base
  before_action :auth_user!

  helper_method :current_user
  helper_method :sing_in?

  def auth_user!
    return if current_user

    if request.method_symbol == :get
      cookies[:redirect_url_after_sign_in] = request.path
    end

    redirect_to sign_in_path
  end

  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def sing_in?
    current_user.present?
  end
end
