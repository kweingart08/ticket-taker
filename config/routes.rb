Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'showtimes#index'

  resources :screens
  resources :movies
  resources :showtimes do
    resources :orders
  end
  resources :orders, only: [:index]

  resources :admin, only: [:index]

end
