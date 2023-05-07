class BrandsController < ApplicationController
  def show
    @brand = Brand.includes(lines: { image_attachment: :blob }).find_by(name: params[:name])
  end
end
