require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product, @another_product, third_product = create_list(:product, 3)
    @line_item = create(:line_item, product: third_product)
  end

  test "should create line_item" do
    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: @product.id }
      #      post line_items_url, params: { line_item: { product_id: @product.id, quantity: rand(10) + 1 } }
    end

    # TODO: complete code below after final iteration
    # follow_redirect!

    # assert_select "some html selector from cart view", "content of that html element"
  end

  # test "should update line_item" do
  #   patch line_item_url(@line_item), params: { line_item: { product_id: @line_item.product_id, quantity: @line_item.quantity } }
  #   assert_redirected_to line_item_url(@line_item)
  # end

  test "should create line_items only if it doesn't exist in the cart" do
    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: @product.id }
    end

    assert_no_difference("LineItem.count") do
      post line_items_url, params: { product_id: @product.id }
    end

    assert_difference("LineItem.count") do
      post line_items_url, params: { product_id: @another_product.id }
    end
  end

  test "should destroy line_item" do
    assert_difference("LineItem.count", -1) do
      delete line_item_url(@line_item)
    end

    assert_redirected_to line_items_url
  end
end
