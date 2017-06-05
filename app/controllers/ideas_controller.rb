class IdeasController < ApplicationController

  def index
    @ideas = Idea.all
  end

  def new
  end

  def create
    # render json: params
    @idea = Idea.new idea_params
    @idea.save
    redirect_to @idea
  end

  def show
    @idea = Idea.find(params[:id])
    # @answers = @question.answers.order(created_at: :desc)
  end

  private

  def idea_params
    idea_params = params.require(:idea).permit([:title, :body])
  end
end
