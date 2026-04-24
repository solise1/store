class CartsController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: %i[ show edit update destroy ]

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: t(".success"), status: :see_other }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    destroy_cart

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path, notice: t(".success"), status: :see_other }
      format.json { head :no_content }
    end
  end

  private
  # def cart_params
  #   params.fetch(:cart, {})
  # end
end
