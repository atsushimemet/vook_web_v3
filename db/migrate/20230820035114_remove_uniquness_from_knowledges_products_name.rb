class RemoveUniqunessFromKnowledgesProductsName < ActiveRecord::Migration[7.0]
  def change
    remove_index :knowledges, :name
    add_index :knowledges, :name

    remove_index :products, :name
    add_index :products, :name
  end
end
