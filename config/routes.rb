Rails.application.routes.draw do
  get("/", { :controller => "movies", :action => "index" })

  # Routes for the Movie resource:
  # CREATE
  get("/movies/new", { :controller => "movies", :action => "new_form" })
  get("/create_movie", { :controller => "movies", :action => "create_row" })

  # READ
  get("/movies", { :controller => "movies", :action => "index" })
  get("/movies/:id_to_display", { :controller => "movies", :action => "show" })

  # UPDATE
  get("/movies/:prefill_with_id/edit", { :controller => "movies", :action => "edit_form" })
  get("/update_movie/:id_to_modify", { :controller => "movies", :action => "update_row" })

  # DELETE
  get("/delete_movie/:id_to_remove", { :controller => "movies", :action => "destroy_row" })

  #------------------------------

  # Routes for the Director resource:

  # CREATE
  get("/directors/new_form", { :controller => "directors", :action => "new_form" })
  post("/create_director", { :controller => "director", :action => "create_row" })

  # READ
  get("/directors", { :controller => "directors", :action => "index" })
  get("/directors/id_to_display", { :controller => "directors", :action => "show" })

  # UPDATE
  get("/directors/:prefill_with_id/edit", { :controller => "directors", :action => "edit_form" })
  get("/update_director/:id_to_modify", { :controller => "directors", :action => "update_row" })

  # DELETE
  get("/delete_director/:id_to_remove", { :controller => "directors", :action => "destroy_row" })

  #------------------------------

  # Routes for the Actor resource:

  # CREATE
  get("/actors/new", { :controller => "actors", :action => "new_form" })
  get("/create_actor", { :controller => "actors", :action => "create_row" })

  # READ
  get("/actors", { :controller => "actors", :action => "index" })
  get("/actors/:id_to_display", { :controller => "actors", :action => "show" })

  # UPDATE
  get("/actors/:prefill_with_id/edit", { :controller => "actors", :action => "edit_form" })
  get("/update_actor/:id_to_modify", { :controller => "actors", :action => "update_row" })

  # DELETE
  get("/delete_actor/:id_to_remove", { :controller => "actors", :action => "destroy_row" })

  #------------------------------
  #------------------------------

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
