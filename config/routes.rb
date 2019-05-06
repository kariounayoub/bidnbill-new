Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get 'users/:id/client_dashboard', to: 'pages#client_dashboard'
  get 'users/:id/provider_dashboard', to: 'pages#provider_dashboard'


  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [] do
        member do
          resources :bills, only: [:index]
        end
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
