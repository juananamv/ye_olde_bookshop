class AddStripeSessionToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :stripe_session, :string
  end
end
