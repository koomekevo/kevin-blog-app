Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "users#index"

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index new create show destroy]
  end

  resources :posts do
    resources :comments, only: %i[create destroy]
    resources :likes, only: %i[create]
  end

  namespace :api, default: {format: :json} do
    namespace :v1,  default: {format: :json} do
      post 'login', to: 'authentication#authenticate'
      post 'register', to: 'users#create'
      resources :users do
        resources :posts, only: [:index, :show, :create] do
          resources :comments, only: [:index, :create]
          resources :likes, only: [:create]
        end
      end
    end
  end

  resources :comments, only: %i[destroy]
  resources :likes, only: %i[destroy]
end
