require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  setup do
    @order = create(:order, "Cash")
  end

  test "received" do
    mail = OrderMailer.received(@order)
    assert_equal "Evas Kunstblumen order confirmation", mail.subject
    assert_equal [ @order.email ], mail.to
    # assert_equal [ "from@example.com" ], mail.from
    # assert_match "Hi", mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(@order)
    assert_equal "Evas Kunstblumen order shipped", mail.subject
    assert_equal [ @order.email ], mail.to
    # assert_equal [ "from@example.com" ], mail.from
    # assert_match "Hi", mail.body.encoded
  end
end
