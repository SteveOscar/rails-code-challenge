Rails.application.routes.draw do
  resources :orders, except: [:destroy, :update]
end
