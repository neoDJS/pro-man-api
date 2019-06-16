Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/auth/facebook/callback' => 'sessions#create'

  # get '/login' => 'sessions#new'
  # post '/login' => 'sessions#create'
  # post '/logout' => 'sessions#destroy'

  # resources :users do #, only: [:new, :create, :edit, :update, :show]
  #   resources :workers, only: [:new]
  #   resources :apps, only: [:index, :new, :create]
  # end

  # root 'welcome#home'

  namespace :api do
    namespace :v1 do
      resources :projects, only: [:index, :create, :update, :show, :destroy], param: :slug do
        resources :todos, only: [:index, :create, :update, :show, :destroy] do
          # resources :user_todos, only: [:new, :create]
          get '/affectation/new' => 'todos#addWorker'
          post '/affectation' => 'todos#affectation'
        end
      end

      resources :users, only: [:index, :create, :update, :show, :destroy] do #, only: [:new, :create, :edit, :update, :show]
        # resources :workers, only: [:new]
      end
      resources :workers, only: [:index, :create, :update, :show, :destroy]

      # get '/login' => 'sessions#new'
      post '/login' => 'sessions#create'
      post '/logout' => 'sessions#destroy'
      
      # get '/auth/facebook/callback' => 'sessions#create'
    end
  end

end
