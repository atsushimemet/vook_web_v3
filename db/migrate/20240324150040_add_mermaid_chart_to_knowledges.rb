class AddMermaidChartToKnowledges < ActiveRecord::Migration[7.1]
  def change
    add_column :knowledges, :mermaid_chart, :text
  end
end
