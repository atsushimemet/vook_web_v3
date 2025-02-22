class Magazine < ApplicationRecord
  belongs_to :user
  has_one_attached :thumbnail
  has_rich_text :body
  acts_as_taggable_on :tags

  validates :title, presence: true, length: { maximum: 255 }

  scope :draft, -> { where(publish_at: nil) }
  scope :published, -> { where('publish_at <= ?', Time.current) }
  scope :scheduled, -> { where('publish_at > ?', Time.current) }
  scope :ranking, lambda {
    joins('INNER JOIN page_views ON page_views.content_id = magazines.id')
      .includes(:tags, thumbnail_attachment: :blob)
      .published
      .where(page_views: { content_type: 'Magazine' })
      .order('page_views.monthly DESC')
  }

  def draft?
    publish_at.nil?
  end

  def published?
    publish_at? && publish_at <= Time.current
  end

  def scheduled?
    publish_at? && publish_at > Time.current
  end
end
