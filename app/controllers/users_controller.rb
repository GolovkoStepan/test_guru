class UsersController < ApplicationController
  skip_before_action :auth_user!
  before_action :redirect_if_sign_in

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to tests_path, notice: 'You have successfully sign up!'
    else
      render :new
    end
  end

  private

  def redirect_if_sign_in
    redirect_to tests_path if current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :middle_name, :email, :password, :password_confirmation)
  end
end
