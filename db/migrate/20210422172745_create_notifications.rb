class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :provider, null: false, foreign_key: true
      t.datetime :schedule_at, null: false
      t.string :title, null: false
      t.string :subtitle
      t.string :body
      t.integer :body_type, null: false
      t.json :data
      t.string :tag
      t.integer :status, null: false, default: 0
      t.timestamps
    end

    add_reference(:notifications, :destiny, polymorphic: true)
  end
end
