Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
  get "/posts", to: "posts#index", as: "post_index"
  get "/posts/new", to: "posts#new", as: "new_post"
  post "posts", to: "posts#create", as: "posts" 
  get "posts/:id", to:"posts#show", as: "post"
  get "posts/:id/edit", to: "posts#edit", as: "edit_post"
  patch "posts/:id", to: "posts#update"

end
