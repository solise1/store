class ProductsController < ApplicationController
  before_action :set_product, only: :show

  def index
    @products = Product.in_stock.page(params[:page].to_i)
  end

  private
    def set_product
      @product = Product.find(params.expect(:id))
    end
end
