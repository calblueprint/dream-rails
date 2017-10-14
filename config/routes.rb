Rails.application.routes.draw do
  namespace :api do
    resources :courses
  	resources :teachers
    resources :attendances
    resources :students
  end
end
