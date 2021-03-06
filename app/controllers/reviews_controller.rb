class ReviewsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @reviews = Review.all
  end

  def new
    @den = Den.find(params[:den_id])
    @review = Review.new
  end

  def create
    @den = Den.find_by(params[:den_id])
    @review = Review.create(review_params)
    if @review.valid?
      flash[:notice] = "Review added."
      respond_to do |format|
        format.html { redirect_to den_path(@den) }
        format.js
      end
    else
      flash[:notice] = "You messed up."
      redirect_to den_path(@den)
    end
  end

  def edit
    @den = Den.find(params[:den_id])
    @review = Review.find(params[:id])
  end

  def update
    @den = Den.find_by(params[:den_id])
    @review = Review.find(params[:id])
    if @review.update(review_params)
      respond_to do |format|
        format.html { redirect_to den_path(@den) }
        format.js
      end
      flash[:notice] = "Review updated."
    else
      render 'edit'
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = "Review deleted"
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  private
    def review_params
      params.require(:review).permit(:content, :rating, :den_id).merge(user_id: current_user.id)
    end
end
