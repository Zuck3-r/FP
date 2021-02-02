require 'rails_helper'

RSpec.describe 'PlannersController', type: :request do

  describe 'GET /planners/new' do
    it 'プランナーの新規登録画面表示に成功' do
      get planners_new_path
      expect(response).to have_http_status(200)
    end
  end
  describe 'POST /planners/new'do
    let!(:planner)
    it 'プランナーを新規登録する' do
      post planners_new_path, params: planner
      expect(response).to redirect_to root_url
    end
  end
end
