class AddCountryToAttractions < ActiveRecord::Migration[5.2]
  def change
    add_column :attractions, :country, :string
  end
end
