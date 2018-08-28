class ShowtimesController < ApplicationController

  def new
    @showtime = Showtime.new
  end

  def index
    @showtimes = Showtime.joins('LEFT JOIN movies ON showtimes.movie_id = movies.id').order('title, time')
  end

  def show
    @showtime = Showtime.find(params[:id])
  end

  def create
    @showtime = Showtime.new(showtime_params)

    # save the movie and redirect to that movie (go to the show view)
    # make sure the movie title is in there so that a blank title can't be submitted. If no title, then render the new form again. If it is in there, go back to the movie show page
    if(@showtime.save)
    redirect_to showtimes_path
    else
      render 'new'
    end
  end

  def edit
    @showtime = Showtime.find(params[:id])
  end

  def update
    @showtime = Showtime.find(params[:id])

    if(@showtime.update(showtime_params))
      redirect_to showtimes_path
    else
      render 'edit'
    end
  end

  def destroy
    @showtime = Showtime.find(params[:id])
    @showtime.destroy
    redirect_to showtimes_path
  end

  private def showtime_params
    params.require(:showtime).permit(:screen_id, :movie_id, :time, :tickets_sold, :price)
  end

end
