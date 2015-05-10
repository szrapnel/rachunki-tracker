Rails.application.routes.draw do
  
  devise_for :users
  #   root 'invoices#index'
  
#   root 'invoices#filtered', filter_name: 'fancy'
  root 'generals#landing_page'

  get 'status' => 'generals#status'
  get 'status_better' => 'generals#status_better'
  get 'status_better2' => 'generals#status_better2'
  get 'set_now' => 'generals#set_now'
  get 'set_now/:actual_date' => 'generals#set_now'
  get 'now_plus_time_in_weeks/:number_of_weeks' => 'generals#now_plus_time_in_weeks'
  get 'now_minus_time_in_weeks/:number_of_weeks' => 'generals#now_minus_time_in_weeks'
  
  get 'invoices/:id/copy_previous_value' => 'invoices#copy_value_from_last'
  
  get 'operators/abandoned' => 'operators#abandoned'
  get 'operators/open' => 'operators#open'
  get 'operators/closed' => 'operators#closed'
  get 'operators/magic_index' => 'operators#magic_index'
  get 'operators/:id/destroy' => 'operators#destroy'
  get 'operators/:id/create_next_invoice' => 'operators#create_next_invoice'
  resources :operators
  
  get 'banks' => 'banks#magic_index' #heroku quickfix
  get 'banks/magic_index' => 'banks#magic_index'
  get 'banks/:id/destroy' => 'banks#destroy'
  resources :banks
  
  resources :tasks
  get 'tasks/:id/destroy' => 'tasks#destroy'
  
  
  get 'operators/:id/postpone_operator' => 'operators#postpone_operator'
  get 'operators/:id/cancel_postpone_operator' => 'operators#cancel_postpone_operator'
  get 'operators/:id/create_me_invoice' => 'operators#create_me_invoice'
  
#   resources :operators do
#     resources :invoices
#   end
  
#   resources :invoices

  #   resources :invoices
  get 'invoices' => 'invoices#index'
  post 'invoices' => 'invoices#index'
  
  get 'invoices/:id/mark_as_paid_and_create_next' => 'invoices#mark_as_paid_and_create_next'
  get 'invoices/:id/mark_as_paid' => 'invoices#mark_as_paid'
  get 'invoices/:id/mark_valid_due_date_true' => 'invoices#mark_valid_due_date_true'
  get 'invoices/:id/mark_valid_due_date_false' => 'invoices#mark_valid_due_date_false'
  get 'invoices/:id/copy_value_from_last' => 'invoices#copy_value_from_last'
  
  get 'invoices/filtered/:filter_name' => 'invoices#filtered'
  
  get 'invoices/done' => 'invoices#done'
  get 'invoices/not_done' => 'invoices#not_done'
  get 'invoices/latest' => 'invoices#latest'
  get 'invoices/overdue' => 'invoices#overdue'
  get 'invoices/fancy' => 'invoices#fancy'
  
  get 'invoices/new' => 'invoices#new'
  post 'invoices/create' => 'invoices#create'
  
  #   popraw to bo nie get
  get 'invoices/:id/destroy' => 'invoices#destroy'
  
  get 'invoices/:id' => 'invoices#show'
  
  get 'invoices/:id/edit' => 'invoices#edit'
  patch 'invoices/:id/update' => 'invoices#update'

  get '/airbrake_test' => 'application#airbrake_test'
  
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
