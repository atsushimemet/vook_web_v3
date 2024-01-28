class BrandsController < ApplicationController
  before_action :set_brand, only: %i[edit update destroy]
  before_action :require_admin_login, only: %i[new edit create update destroy]

  def new
    @brand = Brand.new
  end

  def show
    @brand = Brand.find_by(name: params[:name])
    @lines = @brand.lines.includes(image_attachment: :blob).knowledge_count_order
  end

  def edit; end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      redirect_to admin_path, notice: 'ブランドを登録しました'
    else
      flash.now[:alert] = 'ブランド登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if params[:brand][:name].blank?
      @brand.errors.add(:name, :blank)
      render :edit, status: :unprocessable_entity
    elsif @brand.update(brand_params)
      redirect_to edit_brand_path(@brand), notice: 'ブランドを更新しました'
    else
      flash.now[:alert] = 'ブランド登録に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @brand.lines.blank?
      @brand.destroy
      redirect_to admin_path, notice: 'ブランドを削除しました'
    else
      redirect_to admin_path, alert: 'ラインが存在するので削除できません'
    end
  end

  private

  def set_brand
    @brand = Brand.find_by(name: params[:name])
  end

  def brand_params
    params.require(:brand).permit(:name, :image, :banner, :color, :description)
  end
end
