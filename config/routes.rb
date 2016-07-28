Rails.application.routes.draw do

  resources :top_layer_administrators
  resources :kpi_owners
  resources :subdepartmental_administrators
  resources :departmental_administrators
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  resources :jobtitles
  resources :activities
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
  get 'unlock_user', to: 'users#unlock_user'
  get 'restore', to: 'users#restore'
  get 'activate', to: 'users#activate'
  get 'users/:id/edit_new_user' => 'users#edit_new_user', :as => :edit_new_user
  get 'roles/:id/edit_user_role' => 'roles#edit_user_role', :as => :edit_user_role
  get 'roles/:id/grant_user_access' => 'roles#grant_user_access', :as => :grant_user_access
  get 'roles/:id/edit_user_access' => 'roles#edit_user_access', :as => :edit_user_access
  get 'roles/:id/grant_new_user_access' => 'roles#grant_new_user_access', :as => :grant_new_user_access
  get 'roles/:id/new_user_role' => 'roles#new_user_role', :as => :new_user_role
  get 'kpi_owners/:id/add_admin' => 'kpi_owners#add_admin', :as => :add_admin

  get 'users/:id/edit_active_user' => 'users#edit_active_user', :as => :edit_active_user
  get 'users/:id/edit_user_profile' => 'users#edit_user_profile', :as => :edit_user_profile
  get 'users/:id/set_new_password' => 'users#set_new_password', :as => :set_new_password
  get 'set_super_user' => 'users#set_super_user', :as => :set_super_user

  get 'headings/:id/edit_departmental_headings' => 'headings#edit_departmental_headings', :as => :edit_departmental_headings
  get 'headings/:id/edit_top_layer_headings' => 'headings#edit_top_layer_headings', :as => :edit_top_layer_headings
  get 'headings/:id/edit_capital_projects_headings' => 'headings#edit_capital_projects_headings', :as => :edit_capital_projects_headings
  get 'headings/:id/edit_revenue_by_source_headings' => 'headings#edit_revenue_by_source_headings', :as => :edit_revenue_by_source_headings
  get 'headings/:id/edit_monthly_cashflow_headings' => 'headings#edit_monthly_cashflow_headings', :as => :edit_monthly_cashflow_headings
  get 'export', to: 'departmental_sdbip_progresses#export',defaults: { format: 'csv'}
  get 'departmental_sdbips/:id/edit_kpis' => 'departmental_sdbips#edit_kpis', :as => :edit_kpis
  get 'capital_projects/:id/edit_capital_projects' => 'capital_projects#edit_capital_projects', :as => :edit_capital_projects
  get 'monthly_cashflows/:id/edit_monthly_cashflows' => 'monthly_cashflows#edit_monthly_cashflows', :as => :edit_monthly_cashflows
  get 'top_layer_sdbips/:id/edit_top_layer_sdbips' => 'top_layer_sdbips#edit_top_layer_sdbips', :as => :edit_top_layer_sdbips
  get 'revenue_by_sources/:id/edit_revenue_by_sources' => 'revenue_by_sources#edit_revenue_by_sources', :as => :edit_revenue_by_sources
  post 'export', to: 'departmental_sdbip_progresses#export'
  get 'departmental_sdbips/update_subdepartments', as: 'update_subdepartments'
  get 'departmental_sdbips/:id/audit_performance' => 'departmental_sdbips#audit_performance', :as => :audit_performance
  get 'departmental_sdbips/restore_kpi' => 'departmental_sdbips#restore_kpi', :as => :restore_kpi
  get 'departmental_sdbip_progresses/generate_graphs' => 'departmental_sdbip_progresses#generate_graphs', :as => :generate_graphs
  post 'sdbip_time_periods/update_time_periods' => 'sdbip_time_periods#update_time_periods', :as => :update_time_periods
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
  post 'index', to: 'departmental_sdbip_progresses#index', :as => :index
  resources :departmental_sdbip_progresses do

  end
  resources :kpi_calculation_types
  resources :sdbip_time_periods do
    collection {post :import}
  end
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
