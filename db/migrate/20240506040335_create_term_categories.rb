class CreateTermCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :term_categories do |t|
      t.references :term, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
