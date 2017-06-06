class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def index
  end

  def flag
    @review = Review.find params[:id]
    @review.update(is_flagged: !@review.is_flagged)
    @idea = @review.idea
    redirect_to idea_path(@idea)
  end

  def create
    @review = Review.new(review_params)
    @idea = Idea.find params[:idea_id]
    @review.idea = @idea
    @review.user = current_user

    if cannot? :create, @review
      flash[:alert] = "can't review your own product!!!"
      redirect_to @idea
    elsif
      @review.save
      redirect_to @idea, notice: 'Thank you for submitting a review!'
    else
      flash[:alert] = "Problem creating review"
      render 'products/show'
    end
  end

  def destroy
    @review = Review.find params[:id]
    @idea = Idea.find(params[:idea_id])

    if can? :destroy, @review
      @review.destroy
      flash[:notice] = "Review Successfully Removed"
      redirect_to @idea
    else
      flash[:alert] = 'Access Denied. Only the author may delete this review!'
      redirect_to @idea
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end



end
