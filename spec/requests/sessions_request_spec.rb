require 'rails_helper'
require 'rspec/request_describer'

RSpec.describe "Sessions", type: :request do

  describe 'GET /login' do
    it { is_expected.to eq 200 }
  end

  describe 'planner' do
    let(:planner){ FactoryBot.create(:planner) }

    it 'success login' do
      post login_url, params: { session: { email: planner.email, password: planner.password, flag: 1 } }
      expect(response).to redirect_to planner
      expect(flash[:info]).to eq 'ログインしました'
    end
  end

  describe 'customer' do
    let(:customer){ FactoryBot.create(:customer) }

    it 'success login' do
      post login_url, params: { session: { email: customer.email, password: customer.password, flag: 0 } }
      expect(response).to redirect_to customer
      expect(flash[:info]).to eq 'ログインしました'
    end
  end
end
