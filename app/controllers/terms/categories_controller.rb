module Terms
  class CategoriesController < ApplicationController
    def show
      @category = Category.find_by(name: params[:category_name])
      @terms = @category.terms.includes(:rich_text_description)
      @categories = Category.joins(:term_categories).distinct
    end
  end
end
