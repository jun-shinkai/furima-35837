Rails.application.routes.draw do
  get 'messages/new'
  get 'cards/new'
  get 'users/show'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root to: "items#index"
  resources :users, only: [:new,:show, :update]
  resources :cards, only: [:new, :create]
  resources :items do
    resources :orders,  only:[:index,:create]
    resources :messages, only: [:new,:create]
    collection do
      get 'tag_search'
      get 'search'
    end

  end
end