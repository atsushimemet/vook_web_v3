module API
  class TermsController < ApplicationController
    def index
      terms = Term.all
      render json: TermResource.new(terms)
    end
  end
end
