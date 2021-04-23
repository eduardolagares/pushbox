class CreateSystems < ActiveRecord::Migration[6.1]
  def change
    create_table :systems do |t|
      t.string :name, null: false
      t.string :label, null: false

      t.timestamps
    end
  end
end
