Rails.application.routes.draw do
  defaults format: :json do
    resources :posts
    resources :users do
      get 'posts', to: 'users#posts'
    end
  end
end
