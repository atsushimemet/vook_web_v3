class MagazinesController < ApplicationController
  before_action :set_magazine, only: %i[show edit update destroy]
  before_action :require_admin_login, only: %i[new edit create update destroy]

  def index
    @new_magazines = if admin_login?
                       Magazine.with_attached_thumbnail.order(publish_at: :desc)
                     else
                       Magazine.published.with_attached_thumbnail.order(publish_at: :desc)
                     end
  end

  def show
    raise ActiveRecord::RecordNotFound unless @magazine.published? || admin_login?

    @related_magazines = Magazine.published.with_attached_thumbnail.tagged_with(@magazine.tag_list, any: true)
                                 .where.not(id: @magazine.id).distinct.limit(4)
  end

  def new
    @magazine = Magazine.new
  end

  def edit; end

  def create
    @magazine = current_user.magazines.new(magazine_params)

    if @magazine.save
      redirect_to @magazine, notice: '記事を作成しました'
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @magazine.thumbnail.purge if params[:magazine][:remove_thumbnail] == '1'

    if @magazine.update(magazine_params)
      redirect_to @magazine, notice: '記事を更新しました'
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @magazine.destroy
    redirect_to magazines_path, notice: '記事を削除しました'
  end

  private

  def set_magazine
    @magazine = Magazine.find(params[:id])
  end

  def magazine_params
    params.require(:magazine).permit(:title, :body, :summary, :publish_at, :thumbnail, :tag_list)
  end
end
