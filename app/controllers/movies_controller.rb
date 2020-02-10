class MoviesController < ApplicationController
  def index
    @movies = Movie.all

    render({ :template => "movie_templates/index.html.erb" })
  end

  def show
    @movie = Movie.where({ :id => params.fetch("id_to_display") }).at(0)

    render({ :template => "movie_templates/show.html.erb" })
  end

  def new_form
    render({ :template => "movie_templates/new_form.html.erb" })
  end

  def create_row
    @movie.title = params.fetch("title")
    @movie.year = params.fetch("year")
    @movie.duration = params.fetch("duration")
    @movie.description = params.fetch("description")
    @movie.image = params.fetch("image")
    @movie.save

    redirect_to("/movies")
  end

  def edit_form
    @movie = Movie.where({ :id => params.fetch("prefill_with_id") }).at(0)

    render({ :template => "movie_templates/edit_form.html.erb" })
  end

  def update_row
    @movie.title = params.fetch("title")
    @movie.year = params.fetch("year")
    @movie.duration = params.fetch("duration")
    @movie.description = params.fetch("description")
    @movie.image = params.fetch("image")

    redirect_to("/movies/#{@movie.id}")
  end

  def destroy_row
    movie = Movie.where({ :id => params.fetch("id_to_remove") }).at(0)

    movie.destroy

    redirect_to("/movies")
  end
end
