class CreatePageViews < ActiveRecord::Migration[8.0]
  def change
    create_table :page_views do |t|
      t.string :content_type, null: false
      t.integer :content_id, null: false
      t.integer :monthly
      t.integer :total

      t.timestamps
    end
    add_index :page_views, [:content_type, :content_id], unique: true
  end
end
