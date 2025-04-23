class MagazineResource < BaseResource
  root_key :magazine

  attributes :id, :title, :publish_at

  attribute :thumbnail_url do |magazine|
    if magazine.thumbnail.attached?
      Rails.application.routes.url_helpers.rails_representation_url(
        magazine.thumbnail.variant(resize_to_limit: [400, 400]).processed
      )
    end
  end

  attribute :status do |magazine|
    if magazine.draft?
      'draft'
    elsif magazine.scheduled?
      'scheduled'
    else
      'published'
    end
  end

  attribute :publish_label do |magazine|
    if magazine.draft?
      '下書き'
    elsif magazine.scheduled?
      "予約：#{I18n.l(magazine.publish_at, format: :short)}"
    else
      I18n.l(magazine.publish_at, format: :date)
    end
  end
end
