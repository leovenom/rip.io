class RemoveGuideIdFromMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :guide_id
    remove_column :messages, :tour_id
  end
end
