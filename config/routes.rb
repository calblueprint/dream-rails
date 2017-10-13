Rails.application.routes.draw do
  namespace :api do
    resources :courses
  	resources :teachers
    resources :students
    resources :attendances do
      collection do
        get :attendance_sheet
      end
    end
  end
end
