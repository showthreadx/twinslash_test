Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :ads do
    member do
      put :status_new
      put :status_draft
      delete :delete_image
    end
    collection do
      get 'user_ads' => 'ads#user_ads', as: :user_ads
      get 'user_archive' => 'ads#user_archive', as: :user_archive
    end
  end
  resources :photos do
    get 'preview', on: :member
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "ads#index" 
end
