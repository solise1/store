require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "product attributes must be present" do
    product = Product.new

    assert product.invalid?
    assert product.errors[:name].any?
    assert product.errors[:description].any?
    assert product.errors[:stock].any?
    assert product.errors[:price].any?
  end

  test "name must be unique" do
    older_product = create(:product)

    product = build(:product)
    product.name = older_product.name

    assert product.invalid?
    assert_equal product.errors[:name], [ "has already been taken" ]
  end

  test "price must be bigger than 0 cents" do
    product = build(:product)
    product.price = 0

    assert product.invalid?
    assert_equal product.errors[:price], [ "must be greater than 0" ]
  end

  test "won't be destroyed if it's in a cart" do
    line_item = create(:line_item)

    line_item.product.destroy

    assert_equal line_item.product.errors[:base], [ "Line Items present" ]
    assert Product.exists?(line_item.product_id)
  end
end
