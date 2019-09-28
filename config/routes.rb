Rails.application.routes.draw do

  get "/" => "home#top"
  get "/join_form" => "home#join_form"
  post "/join" => "home#join"
  post "/cancel" => "home#cancel"
  get "/likes" => "home#likes"
  get "/like_serach" => "home#like_serach"
  get "/like_add" => "home#like_add_form"
  post "/like_add" => "home#like_add"
  get "/like/:id" => "home#like"
  post "/like_profile_add/:id" => "home#like_profile_add"
  post "/like_profile_destroy/:id" => "home#like_profile_destroy"


  get "/master" => "master#top"
  get "/master/likes" => "master#likes"
  post "/master/likes_destroy/:id" => "master#likes_destroy"
  post "/master/likes_permission" => "master#likes_permission"
  post "/master/event_add" => "master#event_add"
  post "master/event_destroy/:date" => "master#event_destroy"
  post "master/event_deadline/:date/:gender" => "master#event_deadline"
  get "/participant" => "master#participant"
  get "/participant/:date" => "master#participant_date"
  post "/matching/:date" => "master#matching"
  post "/matched_destroy/:date" => "master#matched_destroy"

  post "/grest_add/:date/:gender" => "master#grest_add"

  get "/signup" => "user#new"
  post "/create" => "user#create"
  get "/login" => "user#login_form"
  post "/login" => "user#login"
  get "/logout" => "user#logout"

  get "/user/top" => "user#top"
  get "/profile/:id" => "user#profile"
  get "/profile_edit/:id" => "user#profile_edit_form"
  post "/profile_edit" => "user#profile_edit"
  post "/user/destroy/:id" => "user#destroy"



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
