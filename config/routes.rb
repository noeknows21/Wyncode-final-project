Rails.application.routes.draw do


  get '/sessions/new' => 'sessions#new'
  post '/sessions/new' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/rooms/create_sesh/:id' => 'rooms#create_sesh'
  get '/rooms/join_sesh/:id' =>'rooms#join_sesh'
  get '/rooms/join_hub'
  get '/rooms/create_hub'
  get '/rooms/create_private/:sesh' => 'rooms#create_private'
  post '/rooms/join_hub' => 'rooms#check_code'
  get '/emotions/display'
  get '/emotions/index'
  post '/emotions/index'
  get '/info/about_tech'
  get '/emotions/graph/:url' => 'emotions#graph'
  get '/emotions/mp4_created'
  post '/emotions/mp4_created'


  resources :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sessions#new'

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
