module API
  class ProductsController < ApplicationController
    def show
      products = Product.includes(:platform).where(knowledge_id: params[:id])
      render json: ProductResource.new(products)
    end
  end
end
