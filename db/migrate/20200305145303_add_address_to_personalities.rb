class AddAddressToPersonalities < ActiveRecord::Migration[5.2]
  def change
    add_column :personalities, :address, :string
  end
end
