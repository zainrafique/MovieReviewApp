class Movie < ApplicationRecord

  has_many :reviews
  has_many :movies_actors
  has_many :actors, through: :movies_actors
  has_many :movies_locations
  has_many :locations, through: :movies_locations

  scope :with_average_rating, -> {
    left_joins(:reviews)
        .group('movies.id')
        .select('movies.*, COALESCE(AVG(reviews.stars), 0) as average_rating')
  }

  def average_rating
    reviews.average(:stars) || 0
  end

end
