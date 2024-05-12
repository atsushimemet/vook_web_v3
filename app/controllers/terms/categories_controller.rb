module Terms
  class CategoriesController < ApplicationController
    def show
      @category = Category.find_by(name: params[:category_name])
      @terms = @category.terms
    end
  end
end
