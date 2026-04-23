require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  test "check dynamic fields" do
    ensure_product_exists

    visit root_url

    find(:id, "add-to-cart").click

    find(:id, "main-cart").click

    click_on "Checkout"

    # assert has_no_field? "Cash"
    # assert has_no_field? "Credit card"

    # select "Cash", from: "Pay type"

    # # TODO : complete this, maybe changing the JS if it's too hard to test

    # assert_nil find_field("Credit card")[:hidden]
    # assert_equal find_field("Credit card")[:hidden], ""

    # select "Credit card", from: "Pay type"

    # assert_equal find_field("Cash")[:hidden], ""
    # assert_nil find_field("Credit card")[:hidden]
  end

  def ensure_product_exists
    create(:product) unless Product.count > 0
  end
end
