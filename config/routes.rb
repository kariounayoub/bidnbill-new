Rails.application.routes.draw do
  get 'contacts/new'
  get 'contacts/create'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, :controllers => {:registrations => "registrations"}
  root to: 'pages#home'

  # Static pages
  get 'donnees_personnels', to: 'pages#donnes_personnels', as: :donnes_personnels
  get 'mentions_legals', to: 'pages#mentions_legals', as: :mentions_legals
  get 'a_propos', to: 'pages#a_propos', as: :a_propos
  get 'cookies', to: 'pages#cookies_page', as: :cookies_page

  resources :contacts, only: [:new, :create]

  # Fake routes for vue-router
  get 'client_dashboard', to: 'pages#client_dashboard', as: :client_dashboard
  get 'provider_dashboard', to: 'pages#provider_dashboard', as: :provider_dashboard
  get 'bills/:id', to: 'pages#client_dashboard'
  get 'users/edit_client', to: 'pages#client_dashboard'
  get 'provider_encheres', to: 'pages#provider_dashboard'
  get 'provider_encheres_lost', to: 'pages#provider_dashboard'
  get 'provider_clients', to: 'pages#provider_dashboard'
  get 'edit_account', to: 'pages#provider_dashboard'
  get 'edit_provider', to: 'pages#provider_dashboard'

  # Api Routes
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:update] do
          resources :bills, only: [:index, :show, :create, :update]
          get 'my_bills', to: 'bills#my_bills'
          get 'my_clients', to: 'bills#my_clients'
          get 'lost_bills', to: 'bills#lost_bills'
          patch 'disable_user', to: 'disable_user'
      end
      resources :bids, only: [:create, :update]
      resources :accounts, only: [:update] do
        post 'new_user', to: 'accounts#new_user'
      end
      patch 'bids/:id/select', to: 'bids#select'
      patch 'notifications/:id/seen', to: 'notifications#seen'
    end
  end


  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
