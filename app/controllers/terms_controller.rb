class TermsController < ApplicationController
  before_action :set_term, only: %i[edit update destroy]
  before_action :require_admin_login, only: %i[new edit create update destroy]

  def index
    @grouped_terms = Term.includes(%i[rich_text_description], { image_attachment: :blob }).grouped_by_kana
    @kana_groups = Term::KANA_GROUPS.keys
    @categories = Category.joins(:terms).distinct
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
    prepare_category

    if @term.save
      redirect_to terms_path, notice: '用語を登録しました'
    else
      flash.now[:alert] = '登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    prepare_category
    @term.image.purge if params[:term][:remove_image] == '1'

    if @term.update(term_params)
      redirect_to terms_path(anchor: @term.name), notice: '用語を更新しました'
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
    params.require(:term).permit(:name, :kana, :description, :image,
                                 categories_attributes: %i[id name],
                                 term_categories_attributes: %i[id term_id category_id])
  end

  def prepare_category
    return unless params[:term][:category_names]

    category_names = params[:term][:category_names].split(',').map(&:strip).uniq
    assign_categories = category_names.map do |name|
      Category.find_or_create_by(name:)
    end

    add_new_categories(assign_categories)
    remove_old_categories(assign_categories)
  end

  def add_new_categories(assign_categories)
    (assign_categories - @term.categories).each do |category|
      @term.categories << category
    end
  end

  def remove_old_categories(assign_categories)
    (@term.categories - assign_categories).each do |category|
      @term.categories.destroy(category)
    end
  end
end
