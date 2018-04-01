Rails.application.routes.draw do
  mount_devise_token_auth_for 'Teacher', at: 'auth'
  devise_for :teachers, skip: [:registrations, :passwords, :sessions]

  devise_scope :teacher do
    post '/sign_up' => 'registrations#create'
  end

  namespace :api do
    resources :courses, shallow: true do
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

    resources :students do
    end
    
  end
end
