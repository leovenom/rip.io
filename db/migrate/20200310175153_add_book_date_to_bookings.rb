class AddBookDateToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :book_date, :string
  end
end
