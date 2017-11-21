Rails.application.routes.draw do
  devise_for :teachers, skip: [:registrations, :passwords]

  devise_scope :teacher do
    post '/sign_up' => 'registrations#create'
  end

  namespace :api do
    resources :courses, shallow: true do
      resources :students
      get 'sessions', to: 'courses#sessions'
    end
  	resources :teachers
    resources :attendances do
      collection do
        post :attendance_item
      end
    end
  end
end
