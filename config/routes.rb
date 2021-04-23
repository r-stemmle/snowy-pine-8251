Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :airlines, only: [:show] do
    resources :flights, only: [:index]
  end

  resources :flights, only: [:index, :update]
end
