Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'showtimes#index'

  resources :screens
  resources :movies
  resources :showtimes do
    resources :orders
  end
  resources :orders do
    collection { post :import }
  end

end
