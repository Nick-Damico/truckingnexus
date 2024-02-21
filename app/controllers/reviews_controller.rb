# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :selected_reviewable, only: %i[index]

  def index
    @reviews = @company.reviews
  end

  def show; end

  def selected_reviewable
    @company = Company.find(params[:company_id])
  end
end
