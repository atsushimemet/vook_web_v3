class HomeController < ApplicationController
  def index
    @brands = Brand.all
    @items = Item.all
    @magazines = Magazine.with_attached_thumbnail.order(publish_at: :desc).limit(4)
  end

  def about
  end
end
