class Admin::DashboardController < ApplicationController
  before_filter :authorize
  http_basic_authenticate_with :name => ENV["ADMIN_USER"], :password => ENV["ADMIN_PW"]
  def show
  end
end
