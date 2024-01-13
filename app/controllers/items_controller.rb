class ItemsController < ApplicationController
  before_action :set_item, only: %i[edit update destroy]
  before_action :require_admin_login, only: %i[new edit create update destroy]

  def new
    @item = Item.new
  end

  def show
    @item = Item.includes(lines: { image_attachment: :blob }).find_by(name: params[:name])
    @lines = @item.lines.includes(:brand).order('brands.display_order')
  end

  def edit; end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to admin_path, notice: 'アイテムを登録しました'
    else
      flash.now[:alert] = 'アイテム登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if params[:item][:name].blank?
      @item.errors.add(:name, :blank)
      render :edit, status: :unprocessable_entity
    elsif @item.update(item_params)
      redirect_to edit_item_path(@item), notice: 'アイテムを更新しました'
    else
      flash.now[:alert] = 'アイテム登録に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.lines.blank?
      @item.destroy
      redirect_to admin_path, notice: 'アイテムを削除しました'
    else
      redirect_to admin_path, alert: 'ラインが存在するので削除できません'
    end
  end

  private

  def set_item
    @item = Item.find_by(name: params[:name])
  end

  def item_params
    params.require(:item).permit(:name, :image, :banner, :color, :description)
  end
end
