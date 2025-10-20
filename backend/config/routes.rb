Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # course
      post 'create_course', to: 'courses#create_course'
      get 'single_course/:identifier', to: 'courses#single_course'
      get 'all_courses', to: 'courses#all_courses'
      patch 'update_course/:id', to: 'courses#update_course'
      delete 'delete_course/:id', to: 'courses#delete_course'

      # user
      post 'create_user', to: 'users#create_user'
      get 'single_user/:slug', to: 'users#single_user'
      get 'all_users', to: 'users#all_users'
      patch 'update_user/:slug', to: 'users#update_user'
      delete 'delete_user/:slug', to: 'users#delete_user'
      get 'restore_user/:slug', to: 'users#restore_user'
    end
  end
end
