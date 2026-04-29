class ContactFormSanitizeAndSendJob < ApplicationJob
  queue_as :default

  def perform(args)
    ContactService.new(args).mail
  end
end
