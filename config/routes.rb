Rails.application.routes.draw do

  #authenticated :user do
  #  root to: 'home#index', as: :home
  # end
  # root to: 'root#index'

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get   'home/index'

end
