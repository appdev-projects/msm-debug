class DirectorsController < ApplicationController
  def index
    directors = Director.all

    render({ :template => "director_templates/index.html.erb" })
  end

  def show
    @director = Director.where({ :id => params.fetch("id_to_display") }).at(0)

    render({ :template => "director_templates/show.html.erb" })
  end

  def new_form
    render({ :template => "director_templates/new_form.html.erb" })
  end

  def create_row
    @director = Director.new

    @director.dob = params.fetch("the_dob")
    @director.name = params.fetch("the_name")
    @director.bio = params.fetch("the_bio")
    @director.image = params.fetch("the_image")

    redirect_to("/directors")
  end

  def edit_form
    @director = Director.where({ :id => params.fetch("prefill_with_id") }).at(0)

    render({ :template => "director_templates/edit_form.html.erb" })
  end

  def update_row
    @director = Director.where({ :id => params.fetch("id_to_modify") }).at(0)

    @director.dob = params.fetch(dob)
    @director.name = params.fetch(name)
    @director.bio = params.fetch(bio)
    @director.image = params.fetch(image)
    @save

    redirect_to("/directors/#{@director.id}")
  end

  def destroy_row
    @director = Director.where({ :id => params.fetch("id_to_remove") }).at(0)

    redirect_to("/directors")
  end
end
