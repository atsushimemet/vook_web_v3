class ProductResource < BaseResource
  root_key :product

  attributes :id, :name, :price, :url, :platform_id

  one :platform, resource: PlatformResource
end
