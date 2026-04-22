class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy

  def add_product(product)
    item = line_items.find_by(product_id: product.id)

    if item
      item.quantity += 1
    else
      item = line_items.build(product_id: product.id, price_in_cents: product.price_in_cents)
    end

    item
  end

  def remove_product(product)
    item = line_items.find_by(product_id: product.id)

    return unless item

    item.quantity -= 1

    if item.quantity.zero?
      item.destroy
      0
    else
      item.save
      item.quantity
    end
  end

  def total_price
    line_items.sum(&:total_price)
  end
end
