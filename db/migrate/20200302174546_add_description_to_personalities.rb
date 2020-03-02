class AddDescriptionToPersonalities < ActiveRecord::Migration[5.2]
  def change
    add_column :personalities, :description, :string
  end
end
