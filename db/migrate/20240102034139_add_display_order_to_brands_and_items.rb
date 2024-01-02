class AddDisplayOrderToBrandsAndItems < ActiveRecord::Migration[7.1]
  def change
    add_column :brands, :display_order, :integer
    add_column :items, :display_order, :integer

    add_index :brands, :display_order, unique: true
    add_index :items, :display_order, unique: true
  end
end
