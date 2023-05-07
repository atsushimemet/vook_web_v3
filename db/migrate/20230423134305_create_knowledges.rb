class CreateKnowledges < ActiveRecord::Migration[7.0]
  def change
    create_table :knowledges do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.references :brand, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.references :line, null: false, foreign_key: true

      t.timestamps
    end
    add_index :knowledges, :name, unique: true
  end
end
