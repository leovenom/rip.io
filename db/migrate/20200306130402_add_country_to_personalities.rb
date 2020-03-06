class AddCountryToPersonalities < ActiveRecord::Migration[5.2]
  def change
    add_column :personalities, :country, :string
  end
end
