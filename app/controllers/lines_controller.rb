class LinesController < ApplicationController
  def index
    brand = Brand.find(params[:brand_id])
    render json: brand.lines.select(:id, :name, :item_id)
  end

  def show
    @line = Line.includes(knowledges: { image_attachment: :blob }).find_by(name: params[:name])
  end
end
