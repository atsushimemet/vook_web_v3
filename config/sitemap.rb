# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://vook.tokyo'

SitemapGenerator::Sitemap.create do
  add '/', changefreq: 'daily', priority: 1.0

  add '/about', changefreq: 'yearly'
  add '/tos', changefreq: 'yearly'
  add '/privacy_policy', changefreq: 'yearly'
  add '/terms', changefreq: 'monthly'

  Knowledge.find_each do |knowledge|
    add knowledge_path(knowledge), lastmod: knowledge.updated_at, changefreq: 'weekly'

    latest_product_update = knowledge.products.maximum(:updated_at)
    add product_path(knowledge), lastmod: latest_product_update, changefreq: 'weekly'
  end

  Magazine.find_each do |magazine|
    add magazine_path(magazine), lastmod: magazine.updated_at, changefreq: 'daily'
  end

  Brand.find_each do |brand|
    add brand_path(brand.name), changefreq: 'monthly'
  end

  Item.find_each do |item|
    add item_path(item.name), changefreq: 'monthly'
  end

  Line.find_each do |line|
    add line_path(line.name), changefreq: 'monthly'
  end
end
