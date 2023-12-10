class TermResource < BaseResource
  root_key :term

  attributes :id, :name, :url

  attribute :url do |term|
    "/terms/##{term.name}"
  end
end
