module MetaTagsHelper
  def default_meta_tags # rubocop:disable Metrics/MethodLength
    {
      reverse: true,
      charset: 'utf-8',
      description: 'ヴィンテージに特化したキュレーションメディア。『古着を楽しむための基本的な知識をわかりやすく解説』',
      keywords: 'ヴィンテージ,古着',
      viewport: 'width=device-width, initial-scale=1.0',
      icon: [
        { href: image_url('favicon.png') }
      ],
      og: {
        site_name: 'Vook',
        description: :description,
        type: 'website',
        url: 'https://vook.tokyo/',
        image: image_url('vook-ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        title: 'Vook',
        card: 'summary_large_image',
        site: '@vintagelevislis',
        description: :description,
        image: image_url('vook-ogp.png'),
        domain: 'https://vook.tokyo/'
      }
    }
  end
end
