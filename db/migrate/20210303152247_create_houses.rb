class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
