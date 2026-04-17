require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @product = create(:product)
    @new_product = build(:product)
    @admin = create(:admin)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new if admin signed in" do
    sign_in @admin
    get new_product_url
    assert_response :success
  end

  test "should redirect from new otherwise" do
    get new_product_url

    assert_redirected_to root_url
  end

  test "should create product if admin signed_in" do
    sign_in @admin

    assert_difference("Product.count") do
      post products_url, params: { product: { description: @new_product.description, name: @new_product.name, price_in_cents: @new_product.price_in_cents, stock: @new_product.stock } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should redirect from create otherwise" do
    assert_no_difference("Product.count") do
      post products_url, params: { product: { description: @new_product.description, name: @new_product.name, price_in_cents: @new_product.price_in_cents, stock: @new_product.stock } }
    end

    assert_redirected_to root_url
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit if admin signed in" do
    sign_in @admin
    get edit_product_url(@product)
    assert_response :success
  end

  test "should redirect from edit otherwise" do
    get edit_product_url(@product)

    assert_redirected_to root_url
  end

  test "should update product if admin signed in" do
    sign_in @admin
    patch product_url(@product), params: { product: { description: @product.description, name: @product.name, price_in_cents: @product.price_in_cents, stock: @product.stock } }
    assert_redirected_to product_url(@product)
  end

  test "should redirect from update otherwise" do
    patch product_url(@product), params: { product: { description: @product.description, name: @product.name, price_in_cents: @product.price_in_cents, stock: @product.stock } }

    assert_redirected_to root_url
  end

  test "should destroy product if admin signed in" do
    sign_in @admin

    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "should redirect from destroy otherwise" do
    assert_difference("Product.count", 0) do
      delete product_url(@product)
    end

    assert_redirected_to root_url
  end
end
