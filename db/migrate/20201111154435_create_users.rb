class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :salt
      t.string :address
      t.string :city
      t.string :postal_code

      t.timestamps
    end
  end
end
