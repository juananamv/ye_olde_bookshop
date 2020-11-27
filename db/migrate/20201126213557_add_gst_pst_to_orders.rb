class AddGstPstToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :gst, :decimal
    add_column :orders, :pst, :decimal
  end
end
