Rails.application.routes.draw do
  
  devise_for :users
  #   root 'invoices#index'
  root 'invoices#filtered', filter_name: 'fancy'

  get 'invoices/status' => 'invoices#status'
  
  get 'invoices/copy_value_from_last/:id' => 'invoices#copy_value_from_last'
  
  get 'operators/abandoned' => 'operators#abandoned'
  get 'operators/destroy/:id' => 'operators#destroy'
  get 'operators/edit/:id' => 'operators#edit'
  resources :operators
  
#   resources :operators do
#     resources :invoices
#   end
  
#   resources :invoices

  #   resources :invoices
  get 'invoices' => 'invoices#index'
  post 'invoices' => 'invoices#index'
  
  get 'invoices/mark_as_done/:id' => 'invoices#mark_as_done'
  
  get 'invoices/mark_valid_due_date_true/:id' => 'invoices#mark_valid_due_date_true'
  
  get 'invoices/mark_valid_due_date_false/:id' => 'invoices#mark_valid_due_date_false'
  
  get 'invoices/filtered/:filter_name' => 'invoices#filtered'
  
  get 'invoices/done' => 'invoices#done'
  get 'invoices/not_done' => 'invoices#not_done'
  get 'invoices/latest' => 'invoices#latest'
  get 'invoices/overdue' => 'invoices#overdue'
  get 'invoices/fancy' => 'invoices#fancy'
  
  get 'invoices/new' => 'invoices#new'
  post 'invoices/create' => 'invoices#create'
  
  #   popraw to bo nie get
  get 'invoices/destroy/:id' => 'invoices#destroy'
  
  get 'invoices/:id' => 'invoices#show'
  
  get 'invoices/edit/:id' => 'invoices#edit'
  patch 'invoices/update/:id' => 'invoices#update'
  
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
