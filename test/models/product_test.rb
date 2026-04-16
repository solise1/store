require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "product attributes must be present" do
    product = Product.new

    assert product.invalid?
    assert product.errors[:name].any?
    assert product.errors[:description].any?
    assert product.errors[:stock].any?
    assert product.errors[:price_in_cents].any?
  end

  test "product name must be unique" do
    older_product = FactoryBot.create(:product)

    product = FactoryBot.build(:product)
    product.name = older_product.name

    assert product.invalid?
    assert_equal product.errors[:name], [ "has already been taken" ]
  end

  test "product price_in_cents must be bigger than 0 cents" do
    product = FactoryBot.build(:product)
    product.price_in_cents = 0

    assert product.invalid?
    assert_equal product.errors[:price_in_cents], [ "must be greater than 0" ]
  end
end
