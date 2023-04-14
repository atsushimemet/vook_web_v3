class HomeController < ApplicationController
  def index
    @magazines = Magazine.order(publish_at: :desc).limit(4)
  end
end
