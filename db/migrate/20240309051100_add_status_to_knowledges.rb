class AddStatusToKnowledges < ActiveRecord::Migration[7.1]
  def change
    add_column :knowledges, :status, :integer, default: 0
  end
end
