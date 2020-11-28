class AddProductIdToOrderItem < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :product_id, :int
  end
end
