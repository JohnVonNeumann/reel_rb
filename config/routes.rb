Rails.application.routes.draw do

  root 'static_pages#home'

  get '/help', to: 'static_pages#help'

  get '/contact', to: 'static_pages#contact'

  get '/about', to: 'static_pages#about'

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  #refer to httpresourceoperationsrequests.md for more guidance on other ops
end
