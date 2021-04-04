class AddPhotoUrlToHouses < ActiveRecord::Migration[6.0]
  def up
    add_column :houses, :photo_url, :string

    # update existing record to contain string to the photo url field
    House.find_each do |house|
      house.update!(photo_url: 'unknown-photo-url')
    end

    # add NOT NULL contraints to the photo_url field
    change_column_null :houses, :photo_url, :string, false
  end

  def down
    remove_column :houses, :photo_url
  end
end
