namespace :import do
  require 'csv'

  desc "Import movies and reviews from CSV"
  task movies_and_reviews: :environment do
    movie_csv_path = 'movies.csv'
    review_csv_path = 'reviews.csv'

    CSV.foreach(movie_csv_path, headers: true) do |row|
      movie = Movie.find_or_create_by(
          title: row['Movie'],
          description: row['Description'],
          year: row['Year'].to_i,
          director: row['Director']
      )
      actor = Actor.find_or_create_by(name: row['Actor'])
      MoviesActor.find_or_create_by(movie: movie, actor: actor)

      location = Location.find_or_create_by(name: row['Filming location'], country: row['Country'])
      MoviesLocation.find_or_create_by(movie: movie, location: location)
    end

    CSV.foreach(review_csv_path, headers: true) do |row|
      movie = Movie.find_by(title: row['Movie'])
      next unless movie

      Review.create(
          movie: movie,
          user: row['User'],
          stars: row['Stars'].to_i,
          review: row['Review']
      )
    end
  end
end
