class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.text :description, null: true
      t.string :external_identifier, null: true, unique: true
      t.timestamps
    end
  end
end
