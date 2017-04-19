Rails.application.routes.draw do
  resources :events do
    resources :people
  end
end
