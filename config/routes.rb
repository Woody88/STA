Rails.application.routes.draw do

  get 'posted-shifts' => 'trade_center#all_posted_shifts', as: 'posted_shifts'
  get 'post_shift/:id' => 'trade_center#post_shift', as: 'post_shift'
  patch 'submit_shift' => 'trade_center#submit_shift', as: 'submit_shift'
  get 'trade_center/pick_up_shift'

  get 'shifts' => 'shifts#index', as: 'shifts'

  resources :bid_lines, only: [:index, :show]

  get 'calendar/index'

  resources :news_feeds
  devise_for :users, :controllers => { :registrations => 'profile_account'}

  devise_scope :user do
    as :user do
      get '/signin' => 'devise/sessions#new'
      post 'signin' => 'devise/sessions#create'
      get '/signup' => 'devise/registrations#new'
      get '/profile/:id' => 'profile_account#edit', as: 'profile'
      put '/profile' => 'profile_account#update'
      delete '/signout' => 'devise/sessions#destroy'
    end
  end

  root 'staticpages#index'

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
