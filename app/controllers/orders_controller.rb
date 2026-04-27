class OrdersController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: %i[ new create ]
  before_action :ensure_cart_isnt_empty, only: :new
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :authorize_admin, only: :index

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        @order.add_line_items_from_cart(@cart)

        destroy_cart

        OrderMailer.received(@order).deliver_later

        format.html { redirect_to root_url, notice: t(".success") }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: t(".success"), status: :see_other }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_path, notice: t(".success"), status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def ensure_cart_isnt_empty
      if @cart.line_items.empty?
        redirect_to root_path, notice: t("orders.new.error.cart_is_empty")
      end
    end

    def set_order
      @order = Order.find(params.expect(:id))
    end

    def order_params
      params.expect(order: [ :name, :address, :email, :pay_type ])
    end
end
