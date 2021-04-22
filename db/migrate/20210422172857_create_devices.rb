class CreateDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :devices do |t|
      t.references :provider, null: false, foreign_key: true
      t.references :system, null: false, foreign_key: true
      t.string :external_identifier, null: true
      t.string :provider_identifier, null: false
      t.json :extra_data, default: {}
      t.json :tags, default: []

      t.timestamps
    end
  end
end
