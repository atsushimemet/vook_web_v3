class ItemsController < ApplicationController
  def show
    @item = Item.includes(lines: { image_attachment: :blob }).find_by(name: params[:name])
  end
end
