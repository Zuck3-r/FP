class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to root_url, success: '登録完了　ログインしてください'
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update; end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end
end

