Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # course
      post 'create_course', to: 'courses#create_course'
      get 'single_course/:slug', to: 'courses#single_course'
      get 'all_courses', to: 'courses#all_courses'
      patch 'update_course/:slug', to: 'courses#update_course'
      delete 'delete_course/:slug', to: 'courses#delete_course'
      get 'restore_course/:slug', to: 'courses#restore_course'

      # user
      post 'create_user', to: 'users#create_user'
      get 'single_user/:slug', to: 'users#single_user'
      get 'all_users', to: 'users#all_users'
      patch 'update_user/:slug', to: 'users#update_user'
      delete 'delete_user/:slug', to: 'users#delete_user'
      get 'restore_user/:slug', to: 'users#restore_user'
      post 'user_login', to: 'users#user_login'

      # country
      post 'create_country', to: 'countrys#create_country'
      get 'single_country/:slug', to: 'countrys#single_country'
      get 'all_countrys', to: 'countrys#all_countrys'
      patch 'update_country/:slug', to: 'countrys#update_country'
      delete 'delete_country/:slug', to: 'countrys#delete_country'
      get 'restore_country/:slug', to: 'countrys#restore_country'

      # student
      post 'create_student', to: 'students#create_student'
      get 'single_student/:slug', to: 'students#single_student'
      get 'all_students', to: 'students#all_students'
      patch 'update_student/:slug', to: 'students#update_student'
      delete 'delete_student/:slug', to: 'students#delete_student'
      get 'restore_student/:slug', to: 'students#restore_student'
    end
  end
end
