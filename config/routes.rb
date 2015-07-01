Rails.application.routes.draw do
  root to: "pages#home"
 resources :institutes do
 end

  devise_for :users
  resources :users, only: [:show, :edit, :update]
end
