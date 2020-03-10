class AddDeathDateToPersonalities < ActiveRecord::Migration[5.2]
  def change
    add_column :personalities, :death_date, :string
  end
end
