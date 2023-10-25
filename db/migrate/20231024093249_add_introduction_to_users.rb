class AddIntroductionToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :introduction, :text
  end
end
