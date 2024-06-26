class LinesController < ApplicationController
  before_action :set_line, only: %i[show edit update destroy]
  before_action :require_admin_login, only: %i[new edit create update destroy]

  def index
    brand = Brand.find(params[:brand_id])
    render json: brand.lines.select(:id, :name, :item_id)
  end

  def show
    redirect_to root_path, alert: 'コンテンツが存在しません' and return if @line.knowledges.published.empty? && !admin_login?

    knowledges_scope = admin_login? ? @line.knowledges : @line.knowledges.published
    @knowledges = knowledges_scope.with_attached_image.order(:age)
  end

  def new
    @line = Line.new
  end

  def edit; end

  def create
    @line = Line.new(line_params)

    if @line.save
      redirect_to admin_path, notice: 'ラインを登録しました'
    else
      flash.now[:alert] = 'ライン登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if params[:line][:name].blank?
      @line.errors.add(:name, :blank)
      render :edit, status: :unprocessable_entity
    elsif @line.update(line_params)
      redirect_to edit_line_path(@line), notice: 'ラインを更新しました'
    else
      flash.now[:alert] = 'ライン登録に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @line.destroy
    redirect_to admin_path, notice: 'ラインを削除しました'
  end

  private

  def set_line
    @line = Line.find_by!(name: params[:name])
  end

  def line_params
    params.require(:line).permit(:name, :image, :brand_id, :item_id)
  end
end
