class MagazinesController < ApplicationController
  before_action :set_magazine, only: %i[show edit update destroy]

  def index
    @magazines = Magazine.all
  end

  def show; end

  def new
    @magazine = Magazine.new
  end

  def edit; end

  def create
    @magazine = Magazine.new(magazine_params)

    if @magazine.save
      redirect_to magazine_url(@magazine), notice: '記事を作成しました'
    else
      render :new
    end
  end

  def update
    if @magazine.update(magazine_params)
      redirect_to magazine_url(@magazine), notice: '記事を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @magazine.destroy
    redirect_to magazines_url, notice: '記事を削除しました'
  end

  private

  def set_magazine
    @magazine = Magazine.find(params[:id])
  end

  def magazine_params
    params.require(:magazine).permit(:title, :body, :summary, :publish_at, :thumbnail)
  end
end
