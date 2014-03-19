Tanmer::Application.routes.draw do
  resources :books
  resources :keystores

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users do
    resources :pages
  end

  #match search/tag special path
  match '/users/:user_id//search(/page/:page)', to: "pages#search", via: :get, as: 'search'
  match '/users/:user_id/tag/:tag(/page/:page)', to: "pages#tag", as: 'tag', via: :get

end