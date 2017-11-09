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
      unlocks: 'users/unlocks',
      omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :retrospects
  resources :posts do
    member do
      put "like", to: "posts#upvote"
      put "dislike", to: "posts#downvote"
    end
  end

  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  controller :help_center do
    get '/about', action: :about
  end
  mount ActionCable.server => '/cable'
end
