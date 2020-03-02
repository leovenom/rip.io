class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.references :user, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
