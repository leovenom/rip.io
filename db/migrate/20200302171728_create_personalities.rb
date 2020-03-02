class CreatePersonalities < ActiveRecord::Migration[5.2]
  def change
    create_table :personalities do |t|
      t.string :name
      t.references :attraction, foreign_key: true

      t.timestamps
    end
  end
end
