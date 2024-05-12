class TermsController < ApplicationController
  before_action :set_term, only: %i[edit update destroy]
  before_action :require_admin_login, only: %i[new edit create update destroy]
  before_action :prepare_category_names, only: %i[create update]

  def index
    @terms = Term.includes([:rich_text_description]).sort_by { |term| term.kana.tr('ァ-ン', 'ぁ-ん') }
  end

  def new
    @term = Term.new
    @term.categories.new
  end

  def edit
    @term.categories.new if @term.categories.blank?
  end

  def create
    @term = Term.new(term_params)

    if @term.save
      redirect_to terms_path, notice: '用語を登録しました'
    else
      flash.now[:alert] = '登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @term.update(term_params)
      redirect_to terms_path, notice: '用語を更新しました'
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @term.destroy
    redirect_to terms_path, notice: '用語を削除しました'
  end

  private

  def set_term
    @term = Term.find(params[:id])
  end

  def term_params
    params.require(:term).permit(:name, :kana, :description, categories_attributes: %i[id name],
                                                             term_categories_attributes: %i[id term_id category_id])
  end

  def prepare_category_names
    return unless params[:term][:category_names]

    category_names = params[:term][:category_names].split(',').map(&:strip).uniq

    assign_categories = category_names.map do |name|
      Category.find_or_create_by(name:)
    end

    add_categories = assign_categories - @term.categories
    add_categories.each do |category|
      @term.categories << category
    end

    remove_categories = @term.categories - assign_categories
    remove_categories.each do |category|
      @term.categories.destroy(category)
    end
  end
end
