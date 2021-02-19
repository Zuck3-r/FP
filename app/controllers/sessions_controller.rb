class SessionsController < ApplicationController
  def new; end

  def create
    case session_params[:flag]
    when '0'
      @user = Customer.find_by(email: session_params[:email])
    when '1'
      @user = Planner.find_by(email: session_params[:email])
    end

    if @user&.authenticate(session_params[:password])
      log_in(@user)
      redirect_to root_url, info: 'ログインしました'
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
end

