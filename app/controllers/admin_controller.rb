class AdminController < ApplicationController
  before_action :require_admin_login, only: %i[show]

  def show
    @brands = Brand.all
    @items = Item.all
    @lines = Line.all
  end
end
