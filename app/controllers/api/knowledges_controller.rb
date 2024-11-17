module API
  class KnowledgesController < ApplicationController
    def index
      knowledges = Knowledge.includes(:brand, :line).all
      render json: KnowledgeResource.new(knowledges)
    end

    def show
      knowledge = Knowledge.find(params[:id])
      render json: KnowledgeMermaidChartResource.new(knowledge)
    end
  end
end
