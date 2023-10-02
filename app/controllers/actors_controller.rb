class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    a = Actor.new
    a.name = params.fetch("name")
    a.dob = params.fetch("dob")
    a.bio = params.fetch("bio")
    a.image = params.fetch("image")

    a.save

    redirect_to("/actors")
  end

  def update
    the_actor = Actor.where( { :id => params.fetch("path_id") }).at(0)

    the_actor.name = params.fetch("name")
    the_actor.dob = params.fetch("dob")
    the_actor.bio = params.fetch("bio")
    the_actor.image = params.fetch("image")

    the_actor.save

    redirect_to("/actors/#{ the_actor.id }")
  end

  def destroy
    the_actor = Actor.where( {:id => params.fetch("path_id") }).at(0)

    the_actor.destroy

    redirect_to("/actors")
  end
end
