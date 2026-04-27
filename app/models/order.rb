class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :email, presence: true

  enum :pay_type, {
    "Cash"        => 0,
    "Credit card" => 1
  }, validate: true

  scope :last_thirty_days, -> { where("created_at > ?", 30.days.ago) }
  scope :last_week, -> { where("created_at > ?", 1.week.ago) }

  def add_line_items_from_cart(cart)
    items = cart.line_items.map do |i|
      {
        order_id: id,
        product_id: i.product_id,
        quantity: i.quantity,
        price: i.price
      }
    end

    LineItem.insert_all(items)
  end

  def total_price
    line_items.sum(&:total_price)
  end
end
