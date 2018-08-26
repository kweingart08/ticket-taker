class ScreensController < ApplicationController

  def index
    @screens = Screen.all
  end

  def show
    @screen = Screen.find(params[:id])
  end

  # create a new screen to show movies
  def new
    @screen = Screen.new
  end

  def create
    # render plain: params[:screen].inspect
    @screen = Screen.new(screen_params)

    if @screen.save
      #this will redirect to the show view of that screen
      redirect_to @screen
    else
      render 'new'
    end
  end

  private def screen_params
    params.require(:screen).permit(:room_number, :capacity)
  end

end
