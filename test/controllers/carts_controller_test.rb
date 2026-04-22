require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = create(:product)
  end

  test "should show cart" do
    get cart_url
    assert_response :success
  end

  test "should destroy cart" do
    post line_items_url, params: { product_id: @product.id }

    assert_difference("Cart.count", -1) do
      delete cart_url
    end

    assert_redirected_to root_url
  end
end
