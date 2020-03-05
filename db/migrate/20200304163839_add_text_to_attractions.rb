class AddTextToAttractions < ActiveRecord::Migration[5.2]
  def change
    add_column :attractions, :text, :string
  end
end
