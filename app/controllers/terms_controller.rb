class TermsController < ApplicationController
  before_action :set_term, only: %i[edit update destroy]
  before_action :require_admin_login, only: %i[new edit create update destroy]

  def index
    @terms = Term.includes([:rich_text_description]).order(:kana)
  end

  def new
    @term = Term.new
  end

  def edit; end

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
    params.require(:term).permit(:name, :kana, :description)
  end
end
