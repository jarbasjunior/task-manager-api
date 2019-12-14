require 'api_version_contraint'

Rails.application.routes.draw do
  devise_for :users, only: [:sessions], controllers: { sessions: 'api/v1/sessions' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json }, path: '/' do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1) do
      resources :users
      resources :sessions, only: %i[create destroy]
      resources :tasks
    end

    namespace :v2, path: '/', constraints: ApiVersionConstraint.new(version: 2, default: true) do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users
      resources :sessions, only: %i[create destroy]
      resources :tasks
    end
  end
end
