class ShowtimesController < ApplicationController

  def index
    @showtimes = Showtime.joins('LEFT JOIN movies ON showtimes.movie_id = movies.id').order('title, time')
  end

  def show
    @showtime = Showtime.find(params[:id])
  end

  private def showtime_params
    params.require(:showtime).permit(:screen_id, :movie_id, :time, :tickets_sold, :price)
  end

end
