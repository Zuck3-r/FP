class SessionsController < ApplicationController
  def new; end

  def create
    @user = set_user
    if @user&.authenticate(session_params[:password])
      log_in(@user)
      redirect_to current_user, info: 'ログインしました'
    else
      redirect_to login_path, danger: 'メールアドレス、パスワードが違います'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, danger: 'ログアウトしました'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :flag)
  end

  def set_user
    if session_params[:flag] == '0'
      Customer.find_by(email: session_params[:email])
    else
      Planner.find_by(email: session_params[:email])
    end
  end
end

