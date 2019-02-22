Rails.application.routes.draw do
  authenticated :user do
    root to: 'spaces#index'  , constraints: { subdomain: ['', 'www'] }
    root to: 'projects#index', constraints: { subdomain: /.+/ }
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

  resource :user, only: [:show, :edit, :update] do
    put :update_image
  end

  constraints(SubdomainRoutes) do
    resources :projects do
      resources :spins do
        member do
          get :get_spin #show는 post를 같이 보여주고 있어서 get_spin을 만듦.ㅠ
        end
        resources :sections do
          member do
            patch :move
          end
          resources :posts, except: [:index, :new] do
            member do
              put 'like', to: 'posts#upvote'
              put 'dislike', to: 'posts#downvote'
              patch :move
            end
          end
        end
      end
    end
  end

  constraints(!SubdomainRoutes) do
    resources :spaces do
      collection do
        get :search
      end
      resources :projects do
        resources :spins do
          member do
            get :get_spin #show는 post를 같이 보여주고 있어서 get_spin을 만듦.ㅠ
          end
          resources :sections do
            member do
              patch :move
            end
            resources :posts, except: [:index, :new] do
              member do
                put 'like', to: 'posts#upvote'
                put 'dislike', to: 'posts#downvote'
                patch :move
              end
            end
          end
        end
      end
    end
  end


  match '/profile/:id/finish_signup', to: 'users#finish_signup', via: [:get, :patch], as: :finish_signup
  get '/spins/:id', to: 'spins#_spin'

  controller :help_center do
    get '/about', action: :about
  end
  mount ActionCable.server => '/cable'

  resources :invitations
end
