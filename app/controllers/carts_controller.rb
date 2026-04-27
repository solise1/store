class CartsController < ApplicationController
  include CurrentCart

  before_action :set_cart, only: %i[show destroy]

  def show
  end

  def destroy
    destroy_cart

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path, notice: t(".success"), status: :see_other }
      format.json { head :no_content }
    end
  end
end
