class ReservationsController < ApplicationController
  before_action :login_required
  before_action :check_planner, only: %i[create destroy]
  before_action :check_customer, only: [:update]

  def create
    @reservation = current_user.reservations.new(reservation_params)

    if @reservation.save
      redirect_to current_user, info: '登録出来ました'
    else
      redirect_to current_user, danger: @reservation.errors.full_messages.join('、')
    end
  end

  def update
    @reservation = Reservation.find_by(id: params[:id])

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

  def destroy
    @reservation = current_user.reservations.find(params[:id])

    if !customer_reserved?
      redirect_to current_user, danger: '予約入ってんぞ～'
    elsif right_planner?
      @reservation.destroy
      redirect_to current_user, success: '削除しました'
    else
      redirect_to root_url, danger: '不正な処理です'
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:time_table_id, :date)
  end

  def right_customer?
    @reservation.customer_id == current_user.id
  end

  def right_planner?
    @reservation.planner_id == current_user.id
  end

  def customer_reserved?
    @reservation.customer_id.nil?
  end
end

