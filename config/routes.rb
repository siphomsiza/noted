Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  resources :jobtitles
  get 'jobtitle/title'

  resources :regions
  resources :master_setups
  resources :top_layer_sdbips do
      collection {post :import}
  end
  root             'sessions#new'

  get 'dashboard' => 'pages#dashboard'
  get 'introduction'    => 'pages#introduction'
  get 'help'    => 'pages#help'
  get 'about'   => 'pages#about'
  get 'contact' => 'pages#contact'
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'pages/setup'
  get 'pages/mastersetup'
  get 'pages/top_layer_administrators'
  get 'pages/dashboard'
  get 'pages/users'
  get 'pages/headings'
  get 'pages/lists'
  get 'pages/timeperiods'
  get 'pages/departments'
  get 'set_admin', to: 'users#set_admin'
  get 'set_normal_user', to: 'users#set_normal_user'
  get 'deactivate', to: 'users#deactivate'
  post 'set_maximum_attempts', to: 'users#set_maximum_attempts'
  get 'terminate', to: 'users#terminate'
  get 'lock_user', to: 'users#lock_user'
  get 'unlock_user', to: 'users#unlock'
  get 'restore', to: 'users#restore'
  get 'activate', to: 'users#activate'
  get 'users/:id/edit_new_user' => 'users#edit_new_user', :as => :edit_new_user
  get 'users/:id/edit_active_user' => 'users#edit_active_user', :as => :edit_active_user

  get 'departmental_sdbip_progresses/:id/show' => 'departmental_sdbip_progresses#show'
  get 'export', to: 'departmental_sdbip_progresses#export',defaults: { format: 'csv'}
  post 'export', to: 'departmental_sdbip_progresses#export'
  get 'departmental_sdbips/update_subdepartments', as: 'update_subdepartments'

  resources :roles
  resources :setups
  resources :departments
  resources :sdbips
  resources :headings
  resources :capital_projects do
    collection {post :import}
  end
  resources :departmental_sdbips do
    collection {post :import}
    collection { post :export }
  end

  resources :departmental_sdbip_progresses do
    post 'departmental_sdbip_progresses/index' => 'departmental_sdbip_progresses#index', :as => :index
  end
  resources :kpi_calculation_types
  resources :sdbip_time_periods
  resources :kpi_target_types
  resources :monthly_cashflows do
    collection {post :import}
  end
  resources :revenue_by_sources
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  resources :lists

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
