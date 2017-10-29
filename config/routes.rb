Rails.application.routes.draw do
  devise_for :teachers

  namespace :api do
    resources :courses, shallow: true do
      resources :students
    end
  	resources :teachers
    resources :attendances do
      collection do
        post :attendance_item
      end
    end
  end
end
