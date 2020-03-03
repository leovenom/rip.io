class AddStartDateToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :start_date, :date
  end
end
