# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :selected_company, only: %i[show]

  def index
    @companies = Company.all.order(:name)
  end

  def show
    @companies = Company.all.order(:name)
  end

  private

  def selected_company
    @company = Company.find(params[:id])
  end
end
