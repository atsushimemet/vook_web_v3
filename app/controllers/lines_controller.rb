class LinesController < ApplicationController
  def index
    brand = Brand.find(params[:brand_id])
    render json: brand.lines.select(:id, :name, :item_id)
  end

  def show
    @line = Line.find_by(name: params[:name])
    @knowledges = @line.knowledges.with_attached_image.order(:age)
  end
end
