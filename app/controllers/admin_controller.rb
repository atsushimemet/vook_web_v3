class AdminController < ApplicationController
  before_action :require_admin_login, only: %i[show]

  def show
    @brands = Brand.order(:display_order)
    @items = Item.order(:display_order)
    @lines = Line.all
  end
end
