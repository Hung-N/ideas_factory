class IdeasController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_idea, only: [:show, :update, :edit, :destroy]

  def index
    @ideas = Idea.all
  end

  def new
    @idea = Idea.new
  end


  def create
    @idea = Idea.new(idea_params)
    @idea.user = current_user

    if @idea.save
      redirect_to idea_path(@idea), notice: 'Successfully created'
    else
      flash[:alert] = "oops, you fucked up!"
      render :new
    end
  end

  def show
    @idea = Idea.find(params[:id])
    # @answers = @question.answers.order(created_at: :desc)
  end

  def destroy
    if can? :destroy, @idea
      @idea.destroy
      redirect_to @idea, notice: "Idea has been Removed"
    else
      flash[:alert] = 'Access Denied. Only the owner may delete this!'
      redirect_to @idea
    end
  end

  private

  def find_idea
    @idea = Idea.find(params[:id])
  end

  def idea_params
    idea_params = params.require(:idea).permit([:title, :body, :user_id])
  end
end
