# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :selected_company, only: %i[show]

  def index
    @companies = Company.includes(:reviews).order(:name)
  end

  def show
    @review_count = @company.reviews.count
    @rating = @company.rating.floor
  end

  private

  def selected_company
    @company = Company.find(params[:id])
  end
end
