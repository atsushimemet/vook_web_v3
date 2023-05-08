class AddUserIdToKnowledges < ActiveRecord::Migration[7.0]
  def change
    add_reference :knowledges, :user, null: false, foreign_key: true
  end
end
