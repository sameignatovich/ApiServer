Rails.application.routes.draw do
  defaults format: :json do
    resources :posts
    resources :users
  end
end
