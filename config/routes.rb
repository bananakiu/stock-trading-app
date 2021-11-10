Rails.application.routes.draw do
  root to: 'welcome#index'
  
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'confirmations' }
  resources :transactions
  get 'portfolio' => 'welcome#portfolio'

  get 'stocks/search'
  post 'stocks/search' => 'stocks#create'
  get 'stocks/:ticker', to: 'stocks#show', as: 'stocks_show'

  namespace :admin do
    resources :users, except: :create
    post 'create_user' => 'users#create', as: :create_user
    patch 'update_user/:id', to: 'users#update', as: :update_user
    delete 'delete_user/:id' => 'users#destory', as: :delete_user
  end
  get 'admin/all_transactions' => 'welcome#all_transactions'
end
