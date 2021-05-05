class CreateDeliveryControls < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_controls do |t|
      t.string :job_id, index: true      
      t.belongs_to :notification, null: false, foreign_key: true
      t.belongs_to :provider, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.integer :provider_identifiers, null: false, array: true, default: []
      t.integer :provider_identifiers_count, null: false, default: 0

      t.timestamps
    end
  end
end
