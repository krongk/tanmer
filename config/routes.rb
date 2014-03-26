Tanmer::Application.routes.draw do
  get "members/index"
  get "members/show"
  get "members/edit"
  get "members/update"
  get "members/destroy"
  resources :page_rates

  devise_for :members
  resources :books
  resources :keystores

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users do
    resources :pages
    resources :members
  end

  #match home search/case special path
  match '/search(/page/:page)', to: "home#search", via: :get, as: 'search'
  match '/case(/page/:page)', to: "home#case", via: :get, as: 'case'
  #tag
  match '/users/:user_id/tag/:tag(/page/:page)', to: "pages#tag", via: :get, as: 'tag'

  #short url
  match '/u/:user_id', to: "pages#index", via: :get
  #match '/:user_id/:id', to: "pages#show", via: :get

  match '/p/u:user_id-p:id', to: "home#show", via: :get
end