class ItemsController < ApplicationController
  def show
    @item = Item.find_by(name: params[:name])
  end
end
