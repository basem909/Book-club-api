Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  namespace :api do
    namespace :v1 do 
      resources :users, only: [:show] do
        resources :all_books, only: [:index, :show, :create, :update]
      end
    end
  end
end
