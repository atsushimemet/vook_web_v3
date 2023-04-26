class LinesController < ApplicationController
  def show
    @line = Line.find_by(name: params[:name])
  end
end
