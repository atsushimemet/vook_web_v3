class CreateLines < ActiveRecord::Migration[7.0]
  def change
    create_table :lines do |t|
      t.string :name, null: false
      t.references :brand, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
    add_index :lines, :name, unique: true
  end
end
