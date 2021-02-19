class PlannersController < ApplicationController
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

  def show; end

  def edit; end

  def update; end

  private

  def planner_params
    params.require(:planner).permit(:name, :email, :password, :password_confirmation, skill_ids: [])
  end
end

