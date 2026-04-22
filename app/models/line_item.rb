class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true
  belongs_to :order, optional: true

  def price
    (price_in_cents / 100.0)
  end

  def total_price
    price * quantity
  end
end
