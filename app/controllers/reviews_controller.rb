# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_review, except: %i[index new create]
  before_action :set_reviewable
  before_action :authorize_user!, only: %i[edit update destroy]

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
      respond_to do |format|
        format.html { redirect_to @reviewable, notice: 'Review successfully saved' }
        format.turbo_stream
      end
    else
      flash.now[:alert] = @review.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      respond_to do |format|
        format.html { redirect_to [@reviewable, @review] }
        format.turbo_stream
      end
    else
      render :edit
    end
  end

  def destroy
    flash[:alert] = @review.errors.full_messages if @review.destroy

    respond_to do |format|
      format.html { redirect_to @reviewable }
      format.turbo_stream
    end
  end

  private

  def authorize_user!
    return if @review.reviewer == current_user

    redirect_to companies_url, flash: { alert: t('flash.unauthorized_access') }
  end

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
