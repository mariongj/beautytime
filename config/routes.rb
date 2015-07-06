Rails.application.routes.draw do
  root to: "pages#home"

  resources :institutes do
    resources :services, only: [:show, :new, :create, :edit, :update, :destroy] do
      resources :bookings, only: [:index, :new, :create, :destroy]
    end
  end

  resources :bookings, only: [:edit, :update]

  devise_for :users
  resources :users, only: [:show, :edit, :update] do
      member do
      get 'bookings', to: "users#bookings"
      get 'institutes', to: "users#institutes"
      end
  end
end
