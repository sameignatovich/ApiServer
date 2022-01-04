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
      delete 'tokens/:id', to: 'tokens#destroy'
    end

    put 'current/profile', to: 'users#update_current_user'
    patch 'current/profile', to: 'users#update_current_user'
    put 'current/avatar', to: 'users#update_current_user_avatar'
    patch 'current/avatar', to: 'users#update_current_user_avatar'
    put 'current/password', to: 'users#update_current_user_password'
    patch 'current/password', to: 'users#update_current_user_password'

    resources :posts do
      resources :comments, only: [:index]
    end
  end
end
