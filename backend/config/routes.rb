Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'create_course', to: 'courses#create_course'
      get 'single_course/:identifier', to: 'courses#single_course'
      get 'all_courses', to: 'courses#all_courses'
      patch 'update_course/:id', to: 'courses#update_course'
      delete 'delete_course/:id', to: 'courses#delete_course'
    end
  end
end
