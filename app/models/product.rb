class Product < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price_in_cents, presence: true
  validates :stock, presence: true
end
