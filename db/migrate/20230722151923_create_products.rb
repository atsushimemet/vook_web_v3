class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.integer :price, null: false
      t.references :knowledge, null: false, foreign_key: true
      t.references :platform, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true

      t.timestamps
    end
    add_index :products, :name, unique: true
    add_index :products, :url, unique: true
  end
end
