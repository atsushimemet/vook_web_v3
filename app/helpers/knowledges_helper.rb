module KnowledgesHelper
  def brand_select_options
    Brand.order(:id).map { |brand| [brand.name, brand.id, { data: { children_path: brand_lines_path(brand) } }] }
  end

  def line_select_options(knowledge)
    knowledge.brand.try(:line).to_a.map { |line| [line.name, line.id] }
  end
end
