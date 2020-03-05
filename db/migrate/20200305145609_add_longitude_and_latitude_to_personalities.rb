class AddLongitudeAndLatitudeToPersonalities < ActiveRecord::Migration[5.2]
  def change
    add_column :personalities, :longitude, :float
    add_column :personalities, :latitude, :float
  end
end
