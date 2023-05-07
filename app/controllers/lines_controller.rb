class LinesController < ApplicationController
  def show
    @line = Line.includes(knowledges: { image_attachment: :blob }).find_by(name: params[:name])
  end
end
