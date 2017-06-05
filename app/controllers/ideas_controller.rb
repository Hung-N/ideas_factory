class IdeasController < ApplicationController

  def new
  end

  def create
    render json: params
  end

end
