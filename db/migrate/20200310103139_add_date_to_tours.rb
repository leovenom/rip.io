class AddDateToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :date, :string
  end
end
