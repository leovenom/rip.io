class AddSkuToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :sku, :string
  end
end
