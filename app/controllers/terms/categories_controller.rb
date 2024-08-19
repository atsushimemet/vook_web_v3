module Terms
  class CategoriesController < ApplicationController
    def show
      @category = Category.find_by!(name: params[:category_name])
      @terms = @category.terms.includes(%i[rich_text_description], { image_attachment: :blob }).sort_by do |term|
        term.kana.tr('ァ-ン', 'ぁ-ん')
      end
      @categories = Category.joins(:term_categories).distinct
    end
  end
end
