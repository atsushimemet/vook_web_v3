class RemoveProfileFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :profile, :string
  end
end
