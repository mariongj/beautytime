Rails.application.routes.draw do
 resources :institutes do
 end

  devise_for :users
end
