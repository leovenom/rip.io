class RemovePriceFromTours < ActiveRecord::Migration[5.2]
  def change
    remove_column :tours, :price, :integer
  end
end
