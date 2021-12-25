Rails.application.routes.draw do
  defaults format: :json do
    controller :information do
      get 'information/summary', to: 'information#summary'
    end

    controller :authorization do
      post 'signin', to: 'signin'
      post 'autologin', to: 'autologin'
      delete 'signout', to: 'signout'
    end

    resources :users, param: :username

    controller :tokens do
      get 'tokens', to: 'tokens#index'
    end

    put 'current/profile', to: 'users#update_current_user'
    patch 'current/profile', to: 'users#update_current_user'

    resources :posts do
      resources :comments, only: [:index]
    end
  end
end
