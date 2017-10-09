Rails.application.routes.draw do
  authenticated :user do
    root to: 'home#index', as: :home
  end
  root to: 'root#index'

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      confirmations: 'users/confirmations',
      passwords: 'users/passwords',
      registrations: 'users/registrations',
      mailer: 'users/mailer',
      shared: 'users/shared',
      unlocks: 'users/unlocks'
  }
  resources :retrospects
  resources :posts

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount ActionCable.server => '/cable'
end
