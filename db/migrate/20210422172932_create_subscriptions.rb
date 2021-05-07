class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :device, null: false, foreign_key: true
      t.boolean :canceled, null: false, default: false

      t.timestamps
    end

    add_index :subscriptions, [:topic_id, :device_id], unique: true
  end
end
