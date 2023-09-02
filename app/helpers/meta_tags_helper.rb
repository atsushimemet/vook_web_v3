module MetaTagsHelper
  def default_meta_tags # rubocop:disable Metrics/MethodLength
    site_name = 'Vook'
    default_title = "#{site_name}｜古着・ヴィンテージを楽しむための新しいメディア"
    default_meta_description = 'ヴィンテージに特化したキュレーションメディアです。古着を楽しむための基本的な知識をわかりやすく解説'
    default_og_image = image_url('vook-ogp.png')

    {
      title: default_title,
      description: default_meta_description,
      keywords: 'ヴィンテージ,古着',
      viewport: 'width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1',
      icon: [
        { href: image_url('favicon.png') }
      ],
      og: {
        title: default_title,
        site_name:,
        description: default_meta_description,
        type: 'website',
        image: default_og_image
      },
      twitter: {
        card: 'summary_large_image',
        site: '@vintagelevislis',
        image: default_og_image
      }
    }
  end
end
