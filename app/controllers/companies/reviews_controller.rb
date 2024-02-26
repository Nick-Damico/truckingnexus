# frozen_string_literal: true

module Companies
  class ReviewsController < ReviewsController
    before_action :set_reviewable

    private

    def set_reviewable
      @reviewable = Company.find(params[:company_id])
    end
  end
end
