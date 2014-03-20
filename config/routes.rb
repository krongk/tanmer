Tanmer::Application.routes.draw do
  resources :books
  resources :keystores

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users do
    resources :pages
  end

  #match home search/case special path
  match '/search(/page/:page)', to: "home#search", via: :get, as: 'search'
  match '/case(/page/:page)', to: "home#case", via: :get, as: 'case'
  #tag
  match '/users/:user_id/tag/:tag(/page/:page)', to: "pages#tag", via: :get, as: 'tag'

  #short url
  match '/:user_id', to: "pages#index", via: :get
  match '/:user_id/:id', to: "pages#show", via: :get
end