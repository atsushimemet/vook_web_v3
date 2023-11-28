class AddInstagramUrlToKnowledges < ActiveRecord::Migration[7.1]
  def change
    add_column :knowledges, :instagram_url, :string
  end
end
