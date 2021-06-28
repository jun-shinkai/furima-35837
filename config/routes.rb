Rails.application.routes.draw do
  get 'messages/new'
  get 'cards/new'
  get 'users/show'
  devise_for :users
  root to: "items#index"
  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create]
  resources :items do
    resources :orders,  only:[:index,:create]
    resources :messages, only: [:new,:create]
  end
end