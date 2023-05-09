class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :icon_url
      t.boolean :admin, default: false, null: false
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps
    end
    add_index :users, %i[provider uid], unique: true
  end
end
