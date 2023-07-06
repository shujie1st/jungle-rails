class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD']
  
  def show
    @product_count = Product.all.length
    @category_count = Category.all.length
  end
end
