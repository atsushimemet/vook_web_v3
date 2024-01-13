class AddDescriptionToBrandsAndItems < ActiveRecord::Migration[7.1]
  def change
    add_column :brands, :description, :text
    add_column :items, :description, :text
  end
end
