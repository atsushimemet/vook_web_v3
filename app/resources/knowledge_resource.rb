class KnowledgeResource < BaseResource
  root_key :knowledge

  attributes :id, :name, :name_with_brand_and_line

  attribute :name_with_brand_and_line do |knowledge|
    "#{knowledge.name} | #{knowledge.brand.name} | #{knowledge.line.name}"
  end
end
