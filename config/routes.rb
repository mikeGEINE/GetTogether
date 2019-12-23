Rails.application.routes.draw do
  root 'events#index'
  scope "(:locale)", locale: /en|ru/ do
    resources :events
    get 'signup', to: 'users#new', as: 'signup'
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'
    get 'current', to: 'users#current', as: 'current_user'
    post 'join/:id', to: 'events#join', as: 'join'
    post 'leave/:id', to: 'events#leave', as: 'leave'
    post 'show_type', to: 'events#show_type', as: 'show_type'
    resources :users, except: :index
    resources :sessions, only: [:new, :create, :destroy]
  end
  get '/:locale' => 'events#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
