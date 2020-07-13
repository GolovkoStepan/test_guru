class SessionsController < ApplicationController
  skip_before_action :auth_user!

  def new; end

  def create
    @user = User.find_by(email: session_params[:email])
    if @user&.authenticate(session_params[:password])
      redirect_url = cookies[:redirect_url_after_sign_in] || root_path

      session[:user_id] = @user.id
      cookies.delete :redirect_url_after_sign_in

      redirect_to redirect_url, notice: 'You have successfully signed in'
    else
      redirect_to sign_in_path, alert: 'Invalid authorization data'
    end
  end

  def destroy
    session[:user_id] = nil if sing_in?
    redirect_to :root, notice: 'You have successfully signed out!'
  end

  def session_params
    @session_params = params.require(:session).permit(:email, :password)
  end
end
