class CreateJoinTableDeliveryDevices < ActiveRecord::Migration[6.1]
  def change
    create_join_table :deliveries, :devices do |t|
      t.index [:delivery_id, :device_id]
      t.index [:device_id, :delivery_id]
    end
  end
end
