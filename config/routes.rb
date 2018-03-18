Rails.application.routes.draw do
  devise_for :teachers, skip: [:registrations, :passwords]

  devise_scope :teacher do
    post '/sign_up' => 'registrations#create'
  end

  namespace :api do
    resources :courses, shallow: true do
      # get 'courses/:course_id' 
      resources :students
      get 'sessions', to: 'courses#sessions'
      get 'teachers', to: 'courses#teachers'
      get 'students', to: 'courses#students'
    end

  	resources :teachers do
      get 'courses', to: 'teachers#courses'
    end

    resources :attendances do
      collection do
        post :attendance_item
      end
    end

    resources :courses_students do
    end

  end
end
