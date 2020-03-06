class AddTextToPersonalities < ActiveRecord::Migration[5.2]
  def change
    add_column :personalities, :text, :string
  end
end
