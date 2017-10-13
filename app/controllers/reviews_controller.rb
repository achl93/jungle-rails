class ReviewsController < ApplicationController

  before_filter :authorize
  before_action :set_reviews, only: [:show, :destroy]

  def create
    @review = Review.new(review_params)
    @product = Product.find params[:product_id]
    @review = @product.reviews.create(review_params)
    @review.user_id = current_user.id

    respond_to do |f|
      if @review.save
        f.html { redirect_to product_path(@product), notice: 'Review posted!' }
      else
        redirect_to :back
      end
    end
  end

  def destroy
    if current_user.id == @review.user_id
      @review.destroy
      respond_to do |f|
        f.html { redirect_to controller: 'products', action: 'show', id: @review.product_id }
      end
    end
  end

  private
  
    def review_params
      params.require(:review).permit(
        :description,
        :rating
      )
    end

    def set_reviews
      @review = Review.find params[:id]
    end

end
