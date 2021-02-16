require 'rails_helper'

RSpec.describe CustomersController, type: :request do

  describe 'GET /customers/new' do
    it { is_expected.to eq 200 }
  end

  describe 'POST /customers'do
    context 'param is correct' do
      let(:customer) { FactoryBot.create(:customer) }
      before { params[:customer] = FactoryBot.attributes_for(:customer) }

      it do
        expect{subject}.to change(Customer, :count).by(1)
        expect(Customer.last.name).to eq customer.name
        is_expected.to eq 302
        expect(flash[:success]).to eq '登録完了　ログインしてください'
      end
    end

    context 'param is not correct' do
      before { params[:customer] = FactoryBot.attributes_for(:customer, email: '') }

      it do
        expect{subject}.not_to change(Customer, :count)
        is_expected.to eq 200
      end
    end
  end
end
