class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :api_key, null: false
      t.integer :role, null: false

      t.timestamps
    end
  end
end
