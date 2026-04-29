class OrderMailer < ApplicationMailer
  def received(order)
    @order = order

    mail(to: order.email)
  end

  def shipped(order)
    @order = order

    mail(to: order.email)
  end
end
