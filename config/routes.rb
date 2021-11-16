Rails.application.routes.draw do
  root to: 'welcome#index'
  
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'portfolio' => 'welcome#portfolio'

  # stocks search
  get 'stocks/search'
  post 'stocks/search', to: 'stocks#create'
  get 'stocks/:ticker', to: 'stocks#show', as: 'stocks_show'
  
  # transactions
  get 'transactions', to: 'transactions#index', as: "transactions"
  get 'transactions/new', to: 'transactions#new', as: "new_transaction"
  post 'transactions', to: 'transactions#create'
  get 'transactions/:id', to: 'transactions#show', as: "transaction"
  get 'transactions/edit', to: 'transactions#edit', as: "edit_transaction"
  patch 'transactions/:id', to: 'transactions#update'
  delete 'transactions/:id', to: 'transactions#destroy'

  # admin pages
  namespace :admin do
    resources :users, except: :create do
      member do
        patch :approve
        put :approve
      end
    end
    post 'create_user' => 'users#create', as: :create_user
    patch 'update_user/:id' => 'users#update', as: :update_user
    delete 'delete_user/:id' => 'users#destory', as: :delete_user
  end
  get 'admin/all_transactions' => 'welcome#all_transactions'
  get 'admin/approvals' => 'welcome#approvals'
end
