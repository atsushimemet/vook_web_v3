class AddSummaryAndTopicSentenceToKnowledges < ActiveRecord::Migration[7.1]
  def change
    add_column :knowledges, :summary, :text
    add_column :knowledges, :topic_sentence, :string
  end
end
