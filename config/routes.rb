Rails.application.routes.draw do

  resources :retrospects
  #authenticated :user do
  #  root to: 'home#index', as: :home
  # end
  # root to: 'root#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    mailer: 'users/mailer',
    shared: 'users/shared',
    unlocks: 'users/unlocks'
  }


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get   'home/index'

end
