class CreateDelivery < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.string :job_id, index: true      
      t.belongs_to :notification, null: false, foreign_key: true
      t.belongs_to :provider, null: false, foreign_key: true
      t.belongs_to :topic, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
