# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show]
  before_action :set_reviewable, only: %i[index new create]

  def index
    @reviews = @reviewable.reviews
  end

  def show; end

  def new
    @review = @reviewable.reviews.new(reviewer: current_user)
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to polymorphic_url([@reviewable, @review]), notice: 'Review successfully saved'
    else
      render :new, alert: @review.errors.full_messages
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :rating, :reviewable_type, :reviewable_id, :reviewer_id)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def set_reviewable
    raise NotImplementedError, "#{params[:reviewable_type]} has not implemented ##{__method__}"
  end
end
