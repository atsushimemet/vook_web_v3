class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update destroy]
  before_action :require_admin_login, only: %i[index edit update destroy]

  # NOTE: 現状、カテゴリーはTermでしか利用されていないが、将来的には他のモデルでも利用される可能性あり。
  # 必要になったときにcreate/showも実装する
  def index
    @categories = Category.all
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'カテゴリーを更新しました'
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: 'カテゴリーを削除しました'
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
