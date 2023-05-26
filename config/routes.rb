Rails.application.routes.draw do
  root 'posts#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/posts", to: "posts#index"
  get "/posts/new", to: "posts#new"
  post "posts", to: "posts#create"
end
