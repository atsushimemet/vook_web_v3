class ProductsController < ApplicationController
  def show
    @knowledge = Knowledge.find(params[:knowledge_id])
    @products = params[:size] ? @knowledge.products.where(size: params[:size]) : @knowledge.products
    @sizes = @products.sizes(@knowledge.id)

    respond_to do |format|
      format.html
      format.js { render partial: 'products/list', locals: { products: @products } }
    end
  end
end
