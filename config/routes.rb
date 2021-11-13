Rails.application.routes.draw do
  root to: 'welcome#index'
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :transactions
  get 'portfolio' => 'welcome#portfolio'

  namespace :admin do
    resources :users, except: :create do
      member do
        patch :approve
        put :approve
      end
    end
    post 'create_user' => 'users#create', as: :create_user
    patch 'update_user/:id', to: 'users#update', as: :update_user
    delete 'delete_user/:id' => 'users#destory', as: :delete_user
  end
  get 'admin/all_transactions' => 'welcome#all_transactions'
  get 'admin/approvals' => 'welcome#approvals'
end
