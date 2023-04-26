class KnowledgesController < ApplicationController
  before_action :set_knowledge, only: %i[show edit update destroy]

  def index
    @knowledges = Knowledge.includes(:line, :brand, :item)
  end

  def show; end

  def new
    @knowledge = Knowledge.new
  end

  def edit; end

  def create
    @knowledge = Knowledge.new(knowledge_params)

    if @knowledge.save
      redirect_to @knowledge, notice: 'ページを作成しました'
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @knowledge.update(knowledge_params)
      redirect_to @knowledge, notice: 'ページを更新しました'
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @knowledge.destroy
    redirect_to knowledges_path, notice: 'ページを削除しました'
  end

  private

  def set_knowledge
    @knowledge = Knowledge.find(params[:id])
  end

  def knowledge_params
    params.require(:knowledge).permit(:name, :age, :body, :brand_id, :item_id, :line_id, :thumbnail)
  end
end
