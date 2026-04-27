class OrderMailer < ApplicationMailer
  # TODO: replace the from to make more sense
  default from: "sol <sol@sol>"

  def received(order)
    @order = order

    mail(to: order.email)
  end

  def shipped(order)
    @order = order

    mail(to: order.email)
  end
end
