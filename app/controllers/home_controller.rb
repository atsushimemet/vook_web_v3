class HomeController < ApplicationController
  def index
    @magazines = Magazine.with_attached_thumbnail.order(publish_at: :desc).limit(4)
  end
end
