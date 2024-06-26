# frozen_string_literal: true

class Review < ApplicationRecord
  INVALID_RATING_MESSAGE = 'must be between 1 & 5'
  NO_RATING_DEFAULT_VALUE = 0

  belongs_to :reviewer, class_name: 'User'
  belongs_to :reviewable, polymorphic: true, touch: true

  validates :title, presence: true
  validates :content, presence: true
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true, in: (1..5), message: INVALID_RATING_MESSAGE }
  # Restricts one Review for a Reviewable( i.e. Company ) per Reviewer
  validates_uniqueness_of :reviewable_id, scope: %i[reviewable_type reviewer_id]

  def self.rating_for(reviewable)
    where(reviewable:).average(:rating) || NO_RATING_DEFAULT_VALUE
  end
end
