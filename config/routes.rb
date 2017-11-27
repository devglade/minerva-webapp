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

  resources :retrospects, shallow: true do
    resources :spins, shallow: true do
      resources :posts, shallow: true do
        member do
          put 'like', to: 'posts#upvote'
          put 'dislike', to: 'posts#downvote'
        end
      end
    end
  end

  get '/retrospects/:retrospect_id/spins/:spin_id/posts', to: 'posts#index'
  post '/retrospects/:retrospect_id/spins/:spin_id/posts', to: 'posts#create'

  get '/spins/new', to: 'spins#new', as: :new_spin
  get '/spins', to: 'spins#index'
  post '/spins', to: 'spins#create'

  get '/posts/new', to: 'posts#new', as: :new_post
  get '/posts', to: 'posts#index'
  post '/posts', to: 'posts#create'

  match '/profile/:id/finish_signup', to: 'users#finish_signup', via: [:get, :patch], as: :finish_signup

  as :user do
    match '/auth/kakao/callback', to: 'users/omniauth_callbacks#kakao', via: [:get, :post]
  end

  controller :help_center do
    get '/about', action: :about
  end
  mount ActionCable.server => '/cable'
end
