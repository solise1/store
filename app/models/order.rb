class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :email, presence: true

  enum :pay_type, {
    "Cash"        => 0,
    "Credit card" => 1
  }, validate: true

  def add_line_items_from_cart(cart)
    items = cart.line_items.map do |i|
      {
        order_id: id,
        product_id: i.product_id,
        quantity: i.quantity,
        price_in_cents: i.price_in_cents
      }
    end

    LineItem.insert_all(items)
  end
end
