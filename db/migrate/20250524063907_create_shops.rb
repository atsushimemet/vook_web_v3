class CreateShops < ActiveRecord::Migration[8.0]
  def change
    create_table :shops do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :shops, :name, unique: true
  end
end
