class CustomersController < ApplicationController
  before_action :login_required, only: %i[show search schedule]
  before_action :login_redirect, only: [:new]
  before_action :check_customer, only: %i[show search schedule]
  before_action :date_nil, only: [:search]
  before_action :check_past_day, only: [:search]

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
    @reservations = Reservation.where(date: params[:date], planner_id: @planners_ids, customer_id: nil)
    return unless @reservations.empty?

    flash.now[:danger] = '一致する予約可能な枠がございません'
    render 'show'
  end

  def schedule
    @reservations = current_user.reservations.after_today
    return unless @reservations.empty?

    flash.now[:info] = '現在、予約している枠は存在しません'
    render 'show'
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end

  def check_past_day
    redirect_to current_user, danger: '明日以降の予定しか検索できません' if Date.current >= params[:date].to_date
  end

  def date_nil
    redirect_to current_user, danger: '日にち空欄だよお' if params[:date].empty?
  end
end

