class CreateProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :provinces do |t|
      t.string :province_code
      t.decimal :tax_rate

      t.timestamps
    end
  end
end
