class ApplicationMailer < ActionMailer::Base
  # TODO: replace the from to make more sense
  default from: "from@example.com"
  layout "mailer"
end
