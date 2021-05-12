class AddNotificationReadOnNotification < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :read, :boolean, null: false, default: false
  end
end
