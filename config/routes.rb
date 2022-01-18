Rails.application.routes.draw do
  defaults format: :json do
    controller :statistics do
      get 'statistics/summary', action: 'summary'
    end

    controller :authorization do
      post 'signin', to: 'signin'
      post 'autologin', to: 'autologin'
      delete 'signout', to: 'signout'
    end

    resources :users, param: :username

    controller :tokens do
      get 'tokens', action: 'index'
      delete 'tokens/:id', action: 'destroy'
    end

    controller :settings do
      put 'settings/profile', action: 'update_profile'
      patch 'settings/profile', action: 'update_profile'
      put 'settings/avatar', action: 'update_avatar'
      patch 'settings/avatar', action: 'update_avatar'
      put 'settings/password', action: 'update_password'
      patch 'settings/password', action: 'update_password'
    end

    resources :posts do
      resources :comments, only: [:index]
    end
  end
end
