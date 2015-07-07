Rails.application.routes.draw do
  root to: "pages#home"

  resources :institutes do
    resources :services, only: [:show, :new, :create, :edit, :update, :destroy]
  collection do                       # collection => no restaurant id in URL
  get 'businesses', to: "institutes#businesses"  # RestaurantsController#top
    end
  end

  resources :services, only: [] do
    resources :bookings, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :timetables, only: [:new, :create, :edit, :update]
  end

  resources :bookings, only: [:update, :edit, :destroy] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:index]

  devise_for :users
  resources :users, only: [:show, :edit, :update] do
      member do
      get 'bookings', to: "users#bookings"
      get 'institutes', to: "users#institutes"
      end
  end
end
