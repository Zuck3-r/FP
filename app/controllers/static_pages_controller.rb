class StaticPagesController < ApplicationController
  before_action :login_redirect, only: %i[home choose]

  def home; end

  def choose; end
end

