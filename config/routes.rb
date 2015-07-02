Rails.application.routes.draw do
  root to: "pages#home"

  resources :institutes do
    resources :services, only: [:show, :new, :create, :edit, :update, :destroy]
  end

  devise_for :users
  resources :users, only: [:show, :edit, :update]
end
