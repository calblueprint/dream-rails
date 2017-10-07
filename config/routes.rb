Rails.application.routes.draw do
  namespace :api do
    resources :courses
  end
end
