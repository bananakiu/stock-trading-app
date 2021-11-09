Rails.application.routes.draw do

  root to: 'welcome#index'
  
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'confirmations' }

  namespace :admin do
    resources :users, except: :create do
      # get 'stocks/show', to: 'stocks#show'
      resources :stock, only: [:show]
    end

    post 'create_user' => 'users#create', as: :create_user
    patch 'update_user/:id', to: 'users#update', as: :update_user
    delete 'delete_user/:id' => 'users#destory', as: :delete_user
  end
end
