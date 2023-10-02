class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def create
    d = Director.new
    d.name = params.fetch("name")
    d.dob = params.fetch("dob")
    d.bio = params.fetch("bio")
    d.image = params.fetch("image")

    d.save

    redirect_to("/directors")
  end

  def update
    d_id = params.fetch("path_id")
    matching_records = Director.where({ :id => d_id })
    this_director = matching_records.at(0)

    this_director.name = params.fetch("name")
    this_director.dob = params.fetch("dob")
    this_director.bio = params.fetch("bio")
    this_director.image = params.fetch("image")

    this_director.save

    redirect_to("/directors/#{this_director.id}")
  end

  def destroy
    d_id = params.fetch("path_id")
    matching_records = Director.where({ :id => d_id })
    this_director = matching_records.at(0)

    this_director.destroy

    redirect_to("/directors")
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
