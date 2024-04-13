class ProductsController < ApplicationController
  def show
    @knowledge = Knowledge.find(params[:knowledge_id])
    @products = @knowledge.products.includes(platform: { image_attachment: :blob }).by_size(params[:size])
    @sizes = Size.where(id: @products.select(:size_id).distinct)

    redirect_to root_path, alert: 'コンテンツが存在しません' and return if @products.empty? && !admin_login?

    respond_to do |format|
      format.html
      format.js { render partial: 'products/list', locals: { products: @products } }
    end
  end
end
