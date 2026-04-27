class Product < ApplicationRecord
  has_many :line_items

  has_one_attached :image

  after_commit -> { broadcast_refresh_later_to "products" }

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :stock, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  before_destroy :ensure_not_referenced_by_any_line_item

  scope :in_stock, -> { where.not(stock: 0) }

  private
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, "Line Items present")
        throw :abort
      end
    end
end
