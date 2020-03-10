class AddPriceToTours < ActiveRecord::Migration[5.2]
  def change
    add_monetize :tours, :price, currency: { present: false }
  end
end
