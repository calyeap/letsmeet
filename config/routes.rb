Rails.application.routes.draw do
  root 'events#index'
  resources :events do
    post 'attend', on: :member
  end
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  patch '/events/:id' => 'events#update'

end
