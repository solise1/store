class AddPriceInCentsToLineItem < ActiveRecord::Migration[8.1]
  def change
    add_column :line_items, :price_in_cents, :integer
  end
end
