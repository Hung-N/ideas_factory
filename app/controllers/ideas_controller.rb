class IdeasController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show, :edit]
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
    # @idea = Idea.find(params[:id])
    @review = Review.new
    @idea.save
  end

  # def edit
  #   unless can? :edit, @idea
  #     flash[:alert] = 'Access Denied. Only the owner may edit this!'
  #     redirect_to @idea
  #   end
  # end
  #
  # def update
  #   if can? :edit, @idea
  #     flash[:alert] = "Access Denied. Only the onwer may update this"
  #     redirect_to @idea
  #   elsif @idea.update(product_params)
  #     redirect_to @idea, notice: "Successfully Updated"
  #   else
  #     render :edit
  #   end
  # end

  def edit
    # head will send an empty HTTP response with a specific code, in this case
    # the code is 401 (:unauthorized).
    head :unauthorized unless can? :edit, @idea
  end

  def update
    if !(can? :update, @idea)
      head :unauthorized
    # idea_params = params.require(:idea).permit([:title, :body]) <-- has been defined as private method below
  elsif @idea.update(idea_params)
      redirect_to idea_path(@idea), notice: 'Successfully updated'
    else
      render :edit
    end
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
