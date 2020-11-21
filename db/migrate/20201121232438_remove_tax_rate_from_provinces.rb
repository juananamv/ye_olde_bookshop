class RemoveTaxRateFromProvinces < ActiveRecord::Migration[6.0]
  def change
    remove_column :provinces, :tax_rate
  end
end
