class ReservationsController < ApplicationController
  before_action :login_required
  before_action :check_planner, only: %i[create destroy]
  before_action :check_customer, only: [:update]

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.planner_id = current_user.id
    if @reservation.save
      redirect_to current_user, info: '登録出来ました'
    else
      redirect_to current_user, danger: '無効な値が指定されています'
    end
  end

  def update
    @reservation = Reservation.find(params[:id])
    if !customer_reserved? && right_customer?
      @reservation.update_attribute(:customer_id, nil)
      redirect_to customers_schedule_url, info: '予約をキャンセルしました'
    elsif customer_reserved?
      @reservation.update_attribute(:customer_id, current_user.id)
      redirect_to customers_schedule_url, info: '予約出来ました'
    else
      redirect_to customers_schedule_url, danger: '先約があります'
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:time_table_id, :date)
  end

  def right_customer?
    @reservation.customer_id == current_user.id
  end

  def customer_reserved?
    @reservation.customer_id.nil?
  end
end

