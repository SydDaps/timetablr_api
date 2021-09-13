require 'sidekiq/web'

Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'students/create'
    end
  end
  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'
  
  namespace :api do
    namespace :v1 do
      resources :token, only: [:create]
      resources :users, only: [:create]
      resources :time_tables, only: [:create, :index, :show]
      
      resources :time_tables do
        resources :rooms, only: [:create, :index, :update, :destroy]
        post '/rooms_tags', to: 'rooms#link_tags'
        
        resources :time_tags, only: [:create, :index, :update, :destroy]
        resources :departments, only: [:create, :index, :update, :destroy]
        resources :lecturers, only: [:create, :index, :update, :destroy]
        resources :students, only: [:create]
        post '/lecturer_days', to: 'lecturers#link_days'

        resources :levels, only: [:create, :index, :destroy, :update]
        resources :courses, only: [:create, :index, :update, :destroy]
        resources :scheduler, only: [:create, :index, :update, :destroy]

        post '/courses_lecturers_tags', to: 'courses#link_lecturers_tags'
      end
    end
  end
  
  
  
end
