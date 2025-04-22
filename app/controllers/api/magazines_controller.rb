module API
  class MagazinesController < ApplicationController
    def index
      magazines = Magazine.all
      render json: MagazineResource.new(magazines)
    end
  end
end
