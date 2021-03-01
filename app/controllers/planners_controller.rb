class PlannersController < ApplicationController
  before_action :login_required, only: %i[edit update show schedule]
  before_action :check_planner, only: %i[edit update show schedule]
  def index; end

  def new
    @planner = Planner.new
    @skills  = Skill.all
  end

  def create
    @planner = Planner.new(planner_params)
    if @planner.save
      redirect_to login_url, success: '登録完了　ログインしてください'
    else
      render 'new'
    end
  end

  def show
    @planner = Planner.find(current_user.id)
    @reservation = Reservation.new
    @reservations = current_user.reservations
    @reservations = @reservations.after_today
    @reservations = @reservations.where(customer_id: nil)
  end

  def edit
    @planner = Planner.find_by(id: current_user.id)
  end

  def update
    @planner = Planner.find_by(id: current_user.id)
    @planner.update_attribute(:skill_ids, params[:planner][:skill_ids])
    redirect_to current_user, success: 'スキルを変更しました'
  end

  def schedule
    @reservations = current_user.reservations
    @reservations = @reservations.after_today
    @reservations = @reservations.filled_reservation
    return unless @reservations.empty?

    redirect_to current_user, info: '現在、予約されている枠はありません'
  end

  private

  def planner_params
    params.require(:planner).permit(:name, :email, :password, :password_confirmation, skill_ids: [])
  end
end

