class Product < ApplicationRecord
  has_one_attached :image

  after_commit -> { broadcast_refresh_later_to "products" }

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :stock, presence: true
  validates :price_in_cents, presence: true, numericality: { greater_than: 0 }

  def price
    (price_in_cents / 100.0)
  end
end
