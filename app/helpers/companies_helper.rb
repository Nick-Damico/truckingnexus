# frozen_string_literal: true

module CompaniesHelper
  def rating(company, display_with_icons: true)
    return 'No Reviews' unless company.reviews.any?

    if display_with_icons
      rating_stars(rating: company.rating)
    else
      pluralize(company.rating.to_i, 'star')
    end
  end
end
