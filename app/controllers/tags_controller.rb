class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.find_by!(name: params[:id])
    @magazines = Magazine.published.with_attached_thumbnail.tagged_with(@tag.name)
  end
end
