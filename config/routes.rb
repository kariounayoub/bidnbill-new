Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => {:registrations => "registrations"}
  root to: 'pages#home'

  get 'client_dashboard', to: 'pages#client_dashboard', as: :client_dashboard
  get 'provider_dashboard', to: 'pages#provider_dashboard', as: :provider_dashboard

  get 'bills/:id', to: 'pages#client_dashboard'
  get 'users/edit_client', to: 'pages#client_dashboard'
  get 'provider_encheres', to: 'pages#provider_dashboard'
  get 'provider_encheres_lost', to: 'pages#provider_dashboard'
  get 'provider_clients', to: 'pages#provider_dashboard'
  get 'users/edit_provider', to: 'pages#provider_dashboard'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:update] do
          resources :bills, only: [:index, :show, :create, :update]
          get 'my_bills', to: 'bills#my_bills'
          get 'my_clients', to: 'bills#my_clients'
          get 'lost_bills', to: 'bills#lost_bills'
      end
      resources :bids, only: [:create, :update]
      patch 'bids/:id/select', to: 'bids#select'
    end
  end


  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
