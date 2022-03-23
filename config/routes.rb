Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "users#index"

  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"

  get "/users/:user_id/posts", to: "user_posts#index"
  get "/users/:user_id/posts/:id", to: "user_posts#show"
end
