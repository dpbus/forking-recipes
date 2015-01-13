RecipeHub::Application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "logout", :to => "devise/sessions#destroy"
    get "login",  :to => "devise/sessions#create"
  end

  match "/browse"                      => "home#browse"
  match "/landing"                     => "home#landing"
  match "/help"                        => 'home#help'
  match "/search"                      => "home#search"

  root :to => "home#index"

  match "/recipes/random"              => "recipes#random",  :via => :get, :as => :random_recipe

  resources :users, path: '' do
    member do
      post :follow
      post :unfollow
    end
    resources :recipes do
      resources :recipe_revisions, path: 'revisions', only: [:index, :show]
      member do
        get 'forks'
        post 'fork'
        get 'random'
        post 'star'
      end
    end
  end
end
