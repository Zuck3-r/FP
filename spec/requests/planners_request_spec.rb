require 'rails_helper'
require 'rspec/request_describer'

RSpec.describe PlannersController, type: :request do

  describe 'GET /planners/new' do
      it { is_expected.to eq 200 }
  end
  describe 'POST /planners'do
    context 'param is correct' do
      let(:planner) { FactoryBot.create(:planner) }
      before do
        params[:planner] = FactoryBot.attributes_for(:planner)
      end
      it do
        expect{subject}.to change(Planner, :count).by(1)
        expect(Planner.last.name).to eq planner.name
        is_expected.to eq 302
        expect(flash[:success]).to eq '登録完了　ログインしてください'
      end
      context 'param is not correct' do
        before do
          params[:planner] = FactoryBot.attributes_for(:planner, email: '')
        end
        it do
        expect{subject}.not_to change(Planner, :count)
        is_expected.to eq 200
        end
      end
    end
  end
end
