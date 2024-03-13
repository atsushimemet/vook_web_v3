class KnowledgesController < ApplicationController
  before_action :set_knowledge, only: %i[show edit update destroy]
  before_action :require_admin_login, only: %i[index new edit create update destroy]

  def index
    @knowledges = Knowledge.includes(:line, :brand, :item).order(:brand_id, :item_id, :line_id, :age)
  end

  def show
    require_admin_login if @knowledge.draft?
  end

  def new
    @knowledge = Knowledge.new
  end

  def edit; end

  def create
    @knowledge = current_user.knowledges.new(knowledge_params)
    @knowledge.item_id = set_item_id

    if @knowledge.save
      redirect_to @knowledge, notice: 'ページを作成しました'
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @knowledge.update(knowledge_params)
      @knowledge.update(item_id: set_item_id)
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

  def set_item_id
    Line.find_by(id: @knowledge.line_id)&.item_id
  end

  def knowledge_params
    params.require(:knowledge).permit(:name, :age, :body, :instagram_url, :brand_id, :line_id, :image, :status)
  end
end
