class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :alias, null: false, unique: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
