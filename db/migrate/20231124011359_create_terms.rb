class CreateTerms < ActiveRecord::Migration[7.1]
  def change
    create_table :terms do |t|
      t.string :name, null: false
      t.string :kana, null: false

      t.timestamps
    end
    add_index :terms, :name, unique: true
    add_index :terms, :kana, unique: true
  end
end
