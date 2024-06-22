class MoviesController < ApplicationController
  def index
    @movies = if params[:actor].present?
                Movie.joins(:actors).where('actors.name ILIKE ?', "%#{params[:actor]}%").with_average_rating
              else
                Movie.with_average_rating
              end

    @movies = @movies.order('average_rating DESC')
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
