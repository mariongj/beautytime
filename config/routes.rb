Rails.application.routes.draw do
  root to: "pages#home"

  resources :institutes, only: [:index, :show] do
    resources :services, only: [:show, :new, :create, :edit, :update, :destroy]
    # collection do                       # collection => no restaurant id in URL
    #   get 'businesses', to: "institutes#businesses"  # InstitutesController#businesses
    # end
    # member do                             # member => institute id in URL
    #   get 'business', to: "institutes#business"  # InstitutesController#business
    # end
  end

  resources :services, only: [] do
    resources :bookings, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :timetables, only: [:new, :create, :edit, :update]
  end

  namespace :business do
    resources :services, only: [] do
      resources :bookings, only: [:index, :show, :new, :create, :edit, :update, :destroy]
      resources :timetables, only: [:new, :create, :edit, :update]
    end

    resources :institutes do
      resources :services, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    end
  end

  resources :bookings, only: [:update, :edit, :destroy] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:index]

  devise_for :users,controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :edit, :update] do
    member do
      get 'bookings', to: "users#bookings"
      get 'institutes', to: "users#institutes"
    end
  end
end
