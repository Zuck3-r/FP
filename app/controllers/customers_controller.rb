class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to login_url, success: '登録完了　ログインしてください'
    else
      render 'new'
    end
  end

  def show; end

  def search
    @planners_ids = PlannerSkill.where(skill: params[:skill_ids]).pluck(:planner_id)
    @reservations = Reservation.where(date: params[:date], planner_id: @planners_ids)
    return unless @reservations.empty?

    flash.now[:danger] = '一致する予約可能な枠がございません'
    render 'show'
  end

  def schedule
    @reservations = Reservation.where(customer_id: current_user.id)
    @reservations = @reservations.where('date >= ?', Date.today)
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end
end

