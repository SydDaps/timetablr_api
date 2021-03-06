

Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

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

      

      post 'student/login', to: 'students#login'
      post 'lecturer/login', to: 'lecturers#login'
      
      resources :time_tables do
        resources :rooms, only: [:create, :index, :update, :destroy]
        post '/rooms_tags', to: 'rooms#link_tags'
        
        resources :time_tags, only: [:create, :index, :update, :destroy]
        resources :departments, only: [:create, :index, :update, :destroy]

        resources :lecturers, only: [:create, :index, :update, :destroy]
        post '/lecturer_days', to: 'lecturers#link_days'

        post '/publish', to: 'time_tables#publish'

        

        
        
        resources :students, only: [:create, :index]
        
        resources :levels, only: [:create, :index, :destroy, :update]
        resources :courses, only: [:create, :index, :update, :destroy]
        resources :scheduler, only: [:create, :index, :update, :destroy]

        post '/courses_lecturers_tags', to: 'courses#link_lecturers_tags'
      end
    end
  end
  
  
  
end
