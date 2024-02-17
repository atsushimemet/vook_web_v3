module API
  class KnowledgesController < ApplicationController
    def index
      knowledges = Knowledge.includes(:brand, :line).all
      render json: KnowledgeResource.new(knowledges)
    end
  end
end
