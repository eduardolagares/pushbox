class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :device, null: false, foreign_key: true
      t.integer :status, null: false
      t.boolean :canceled, null: false, default: false

      t.timestamps
    end
  end
end
