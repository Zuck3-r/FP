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

  private

  def reservation_params
    params.require(:reservation).permit(:time_table_id, :date)
  end
end

