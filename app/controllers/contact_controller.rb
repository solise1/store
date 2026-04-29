class ContactController < ApplicationController
  def new
  end

  def create
    ContactFormSanitizeAndSendJob.perform_later(contact_params)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to contact_success_path, status: :created }
      format.json { head :no_content }
    end
  end

  def success
  end

  private
    def contact_params
      params.permit(:body, :subject, :email)
    end
end
