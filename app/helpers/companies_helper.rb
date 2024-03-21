# frozen_string_literal: true

module CompaniesHelper
  def rating(company)
    return 'No Reviews' unless company.reviews.any?

    pluralize(company.rating.to_i, 'star')
  end
end
