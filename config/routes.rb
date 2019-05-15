Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get 'client_dashboard', to: 'pages#client_dashboard', as: :client_dashboard
  get 'provider_dashboard', to: 'pages#provider_dashboard', as: :provider_dashboard

  get 'bills/:id', to: 'pages#client_dashboard'
  get 'provider_encheres', to: 'pages#provider_dashboard'
  get 'provider_clients', to: 'pages#provider_dashboard'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [] do
          resources :bills, only: [:index, :show, :create]
          get 'my_bills', to: 'bills#my_bills'
          get 'my_clients', to: 'bills#my_clients'
      end
      resources :bids, only: [:create]
      patch 'bids/:id/select', to: 'bids#select'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
