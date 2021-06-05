Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :token, only: [:create]
      resources :users, only: [:create]
      resources :time_tables, only: [:create, :index]
      
      resources :time_tables do
        resources :rooms, only: [:create, :index, :link_tags]
        post '/rooms_tags', to: 'rooms#link_tags'
        
        resources :time_tags, only: [:create, :index]
        resources :departments, only: [:create, :index]
        resources :lecturers, only: [:create, :index]
        resources :levels, only: [:create, :index]
        resources :courses, only: [:create, :index]
        post '/courses_lecturers_tags', to: 'courses#link_lecturers_tags'
      end
    end
  end
  
  
  
end
