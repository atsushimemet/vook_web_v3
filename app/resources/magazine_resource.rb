class MagazineResource < BaseResource
  root_key :magazine

  attributes :id, :title, :publish_at, :tag_list
end
