class AdminController < ApplicationController

  def index

  end

  def showtimes
    @showtimes = Showtime.all
  end

end
