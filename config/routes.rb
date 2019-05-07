Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get 'client_dashboard', to: 'pages#client_dashboard', as: :client_dashboard
  get 'provider_dashboard', to: 'pages#provider_dashboard', as: :provider_dashboard

  get 'bills/:id', to: 'pages#client_dashboard'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [] do
          resources :bills, only: [:index, :show]
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
