class ReviewsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.post = @post
    @review.save
    redirect_to posts_path(@post)
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
