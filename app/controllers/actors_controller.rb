class ActorsController < ApplicationController
  def index
    @actors = Actor.all

    render({ :template => "actor_templates/index.html.erb" })
  end

  def show
    @actor = Actor.where({ :id => fetch("id_to_display") })

    render({ :template => "actor_templates/show.html.erb" })
  end

  def new_form
    render({ :template => "actor_templates/new_form.html.erb" })
  end

  def create_row
    @actor = Actor.new

    @actor.dob = fetch("dob")
    @actor.name = fetch("name")
    @actor.image = fetch("image")
    @actor.save

    redirect_to("/actors")
  end

  def edit_form
    @actor = Actor.where({ :id => fetch("prefill_with_id") }

    render({ :template => "actor_templates/edit_form.html.erb" })
  end

  def update_row
    @actor = Actor.where({ :id => fetch("id_to_modify") }).first

    @actor.dob = fetch("dob")
    @actor.name = fetch("name")
    @actor.bio = fetch("bio")
    @actor.image = fetch("image")
    @actor.save

    redirect_to("/actors/#{@actor.id}")
  end

  def destroy_row

    @actor.destroy

    redirect_to("/actors")
  end
end
