Rails.application.routes.draw do
  resources :events do
    resources :people
  end
   post 'auth/login', to: 'authentication#authenticate'
   post 'signup', to: 'users#create'
end
