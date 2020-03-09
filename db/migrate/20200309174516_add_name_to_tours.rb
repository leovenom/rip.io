class AddNameToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :name, :string
  end
end
