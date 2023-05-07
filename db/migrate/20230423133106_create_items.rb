class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :items, :name, unique: true
  end
end
