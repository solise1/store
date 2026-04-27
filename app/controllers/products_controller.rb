class ProductsController < ApplicationController
  include Paginable

  before_action :set_product, only: :show

  def index
    @per_page = 6

    @products = paginate(Product.in_stock, @per_page)
  end

  def show
  end

  private
    def set_product
      @product = Product.find(params.expect(:id))
    end
end
