class CreateProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :providers do |t|
      t.string :name, null: false
      t.json :config, default: {}
      t.string :delivery_class_name, null: false
      t.string :label, null: false, unique: true

      t.timestamps
    end
  end
end
