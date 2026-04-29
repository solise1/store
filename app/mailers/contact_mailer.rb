class ContactMailer < ApplicationMailer
  # TODO - ask client for email
  def contact(params)
    @email = params[:email]
    @body = params[:body]
    mail(to: ENV["CONTACT_EMAIL"], subject: params[:subject])
  end
end
