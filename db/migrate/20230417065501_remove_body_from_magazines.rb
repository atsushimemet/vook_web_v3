class RemoveBodyFromMagazines < ActiveRecord::Migration[7.0]
  def change
    remove_column :magazines, :body, :text
  end
end
