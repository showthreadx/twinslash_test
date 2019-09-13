Rails.application.routes.draw do
  resources :ads do
    member do
      patch :approve
      put :approve
      patch :pending
      put :pending
    end
  end
  resources :photos do
    get 'preview', on: :member
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "ads#index" 
end
