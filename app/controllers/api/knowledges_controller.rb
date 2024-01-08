module API
  class KnowledgesController < ApplicationController
    def index
      knowledges = Knowledge.all
      render json: KnowledgeResource.new(knowledges)
    end
  end
end
