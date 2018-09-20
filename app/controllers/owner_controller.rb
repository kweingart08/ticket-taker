class OwnerController < ApplicationController

  def index

  end

  def showtimes
    @showtimes = Showtime.joins('LEFT JOIN movies ON showtimes.movie_id = movies.id').order('title, time')
  end

end
