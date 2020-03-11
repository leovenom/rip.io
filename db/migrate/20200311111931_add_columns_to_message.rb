class AddColumnsToMessage < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :conversation, foreign_key: true
    add_column :messages, :read, :boolean, default: false
  end
end
