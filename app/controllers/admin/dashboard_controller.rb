class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]
  
  # p Product.count
  # p Category.count
  def show
    @productCount = Product.count
    @categoryCount = Category.count
  end
end
