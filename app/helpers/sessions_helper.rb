module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    case user.class.name
    when 'Planner'
      session[:role] = 'Planner'
    when 'Customer'
      session[:role] = 'Customer'
    end
  end

  def current_user
    if session[:user_id] && session[:role] == 'Planner'
      @current_user ||= Planner.find_by(id: session[:user_id])
    elsif session[:user_id] && session[:role] == 'Customer'
      @current_user ||= Customer.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def planner_user?
    session[:role] == 'Planner'
  end

  def customer_user?
    session[:role] == 'Customer'
  end

  def current_user?(user)
    user == current_user
  end

  def log_out
    session.delete(:user_id)
    session.delete(:role)
    @current_user = nil
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'ログインしてください！'
    redirect_to login_url
  end

  def correct_user
    if session[:user_id] && session[:role] == 'Planner'
      if Planner.exists?(id: params[:id])
        @user = Planner.find(params[:id])
        redirect_to(root_url) unless @user == current_user
      else
        redirect_to(root_url)
      end
    elsif session[:user_id] && session[:role] == 'Customer'
      if Customer.exists?(id: params[:id])
        @user = Customer.find(params[:id])
        redirect_to(root_url) unless @user == current_user
      else
        redirect_to(root_url)
      end
    end
  end
end

