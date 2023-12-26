class AddColorToBrandsAndItems < ActiveRecord::Migration[7.1]
  def change
    add_column :brands, :color, :string
    add_column :items, :color, :string
  end
end
