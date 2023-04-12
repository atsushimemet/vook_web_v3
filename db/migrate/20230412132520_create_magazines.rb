class CreateMagazines < ActiveRecord::Migration[7.0]
  def change
    create_table :magazines do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :summary
      t.datetime :publish_at

      t.timestamps
    end
  end
end
