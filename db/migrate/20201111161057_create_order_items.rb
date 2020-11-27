class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.string :product_name
      t.integer :count
      t.decimal :subtotal
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
