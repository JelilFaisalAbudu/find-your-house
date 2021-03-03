class RenameTypeToCategoryInHouses < ActiveRecord::Migration[6.0]
  def change
    rename_column :houses, :type, :category
  end
end
