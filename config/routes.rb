Rails.application.routes.draw do
  authenticated :user do
    root to: 'retrospects#index'
  end
  root to: 'root#index'

  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 confirmations: 'users/confirmations',
                 passwords: 'users/passwords',
                 registrations: 'users/registrations',
                 mailer: 'users/mailer',
                 shared: 'users/shared',
                 unlocks: 'users/unlocks'
             },
             path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 sign_up: 'signup'
             }
  
  resources :retrospects do
    resources :spins do
      resources :posts do
        member do
          put 'like', to: 'posts#upvote'
          put 'dislike', to: 'posts#downvote'
        end
      end
    end
  end

  match '/profile/:id/finish_signup', to: 'users#finish_signup', via: [:get, :patch], as: :finish_signup

  controller :help_center do
    get '/about', action: :about
  end
  mount ActionCable.server => '/cable'
end
