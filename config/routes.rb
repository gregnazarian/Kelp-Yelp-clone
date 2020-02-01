Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    root 'places#index'
    resources :places do 
      resources :comments, only: :create
    end

    get "kelp/new_release" => 'kelp#new_release', :as => :new_release


end
