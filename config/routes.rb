require 'api_version_constraint'

Rails.application.routes.draw do
  devise_for :users,only: [:sessions], controllers: {sessions: 'api/v1/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json},constraints: {subdomain: 'api'}, path: '/' do
    namespace :v1, path: '/' ,constraints: ApiVersionConstraint.new(version: 1,default: true)do
      resources :users, only:[:show,:create,:update,:destroy] 
      resources :sessions, only:[:create] 
      resources :tasks, only:[:index] 
      
    end

  #  namespace :v2, path: "/" ,contraints: ApiVersionConstraint.new(version: 2,default: true )do
   # resources :tasks
    
  #end
  end
end