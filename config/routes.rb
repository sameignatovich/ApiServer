Rails.application.routes.draw do
  defaults format: :json do
    controller :information do
      get 'information/summary', to: 'information#summary'
    end
    resources :users do
      get 'posts', to: 'users#posts'
    end
    resources :posts
    controller :comments do
      get 'posts/:id/comments', to: 'comments#show'
    end
  end
end
