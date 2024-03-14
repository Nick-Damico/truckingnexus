# frozen_string_literal: true

module ReviewHelper
  include ApplicationHelper

  ACTIVE_STAR_CLASS = 'star-icon--active'

  def rating_stars(rating:, count: 5, **kwargs)
    rating ||= 0
    klasses = kwargs[:class] || ''

    count.times.map do |i|
      render_icon(:star, classes: "w-6 #{ACTIVE_STAR_CLASS if i < rating} #{klasses}")
    end.join.html_safe
  end

  def active_star_class
    ACTIVE_STAR_CLASS
  end
end
