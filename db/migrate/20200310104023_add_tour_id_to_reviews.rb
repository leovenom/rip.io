class AddTourIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :tour_id, :integer
  end
end
