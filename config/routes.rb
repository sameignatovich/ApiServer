Rails.application.routes.draw do
  defaults format: :json do
    controller :information do
      get 'information/summary', to: 'information#summary'
    end
    resources :posts
    resources :users do
      get 'posts', to: 'users#posts'
    end
  end
end
