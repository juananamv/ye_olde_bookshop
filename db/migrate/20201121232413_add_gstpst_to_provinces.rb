class AddGstpstToProvinces < ActiveRecord::Migration[6.0]
  def change
    add_column :provinces, :gst, :decimal
    add_column :provinces, :pst, :decimal
  end
end
