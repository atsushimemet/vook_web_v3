class PlatformResource < BaseResource
  root_key :platform

  attributes :image_url

  def image_url(platform)
    "/assets/platform_#{platform.name.downcase}.png"
  end
end
