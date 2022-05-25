class AddVehicleToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :vehicle, null: true, foreign_key: true
  end
end
