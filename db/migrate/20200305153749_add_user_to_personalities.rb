class AddUserToPersonalities < ActiveRecord::Migration[5.2]
  def change
   add_reference :personalities, :user, foreign_key: true
 end
end
