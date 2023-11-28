module KnowledgesHelper
  def brand_select_options
    Brand.order(:id).map { |brand| [brand.name, brand.id, { data: { children_path: brand_lines_path(brand.id) } }] }
  end

  def line_select_options(knowledge)
    Line.where(brand_id: knowledge.brand_id).map { |line| [line.name, line.id] }
  end

  def instagram_embed(instagram_url)
    embed_url = instagram_url.gsub('ig_web_copy_link', 'ig_embed')
    render 'shared/instagram_embed', instagram_url: embed_url
  end
end
