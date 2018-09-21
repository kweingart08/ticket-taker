class MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    # render plain: params[:movie].inspect
    @movie = Movie.new(movie_params)

    if @movie.save
      #this will redirect to the show view of that movie
      redirect_to movies_path
    else
      render 'new'
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      #this will redirect to the show view of that movie
      redirect_to movies_path
    else
      render 'edit'
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  private def movie_params
    params.require(:movie).permit(:title)
  end


end
