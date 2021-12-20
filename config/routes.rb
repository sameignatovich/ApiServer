Rails.application.routes.draw do
  defaults format: :json do
    controller :authorization do
      post 'signin', to: 'signin'
      post 'autologin', to: 'autologin'
      delete 'signout', to: 'signout'
    end
    controller :information do
      get 'information/summary', to: 'information#summary'
    end
    resources :users do
      get 'posts', to: 'users#posts'
    end
    resources :posts do
      resources :comments
    end
  end
end
