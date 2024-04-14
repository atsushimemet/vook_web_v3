module API
  class TagsController < ApplicationController
    def index
      tags = ActsAsTaggableOn::Tag.all
      render json: TagResource.new(tags)
    end
  end
end
