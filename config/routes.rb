Rails.application.routes.draw do
  get 'friends' => 'friends#index'
  root 'events#index'
  resources :events do
    post 'attend', on: :member
  end
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  patch '/events/:id' => 'events#update'

  resources :users do
    post 'request_friend', on: :member
    post 'accept_friend', on: :member
    post 'decline_friend', on: :member
    post 'remove_friend', on: :member
  end
end
