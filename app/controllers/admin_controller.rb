class AdminController < ApplicationController
  before_action :authorize_admin

  def dashboard
    @products = Product.all
    @orders = Order.all # Maybe add boolean "archived" and filter by that
    @estimated_income_thirty_days = Order.last_thirty_days.sum(&:total_price)
    @estimated_income_seven_days = Order.last_week.sum(&:total_price)
    @users = User.regular
  end
end
