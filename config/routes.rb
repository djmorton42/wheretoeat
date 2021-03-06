Rails.application.routes.draw do
    root 'application#hello'

    get 'group' => "group#get_groups"

    post 'user' => "user#create_user"
    get 'user/:user_id' => "user#get_user"

    post 'user/:user_id/group' => "group#create_group"

    post 'user/:user_id/group/:group_id/restaurant' => "restaurant#create_restaurant"
    get  'user/:user_id/group/:group_id/restaurant' => "restaurant#get_restaurants"
    get  'user/:user_id/group/:group_id/restaurant/:restaurant_id' => "restaurant#get_restaurant"

    post  'user/:user_id/group/:group_id/event' => "event#create_event"
    get   'user/:user_id/group/:group_id/event/:event_id' => "event#get_event"
    patch 'user/:user_id/group/:group_id/event/:event_id' => "event#patch_event"
    put   'user/:user_id/group/:group_id/event/:event_id' => "event#update_event"

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

