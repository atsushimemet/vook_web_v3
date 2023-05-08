class AddUserIdToMagazines < ActiveRecord::Migration[7.0]
  def change
    add_reference :magazines, :user, null: false, foreign_key: true
  end
end
