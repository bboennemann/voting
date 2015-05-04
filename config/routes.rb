Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

# Basic Routes
  root 'votings#index'
  devise_for :users

# users
  resources :users, only: [:update, :destroy, :show, :edit] do 
    resources :friends
    resources :friend_requests
    resources :bookmarks, only: [:index, :destroy]
  end

# voting wizard 
  get 'voting_wizards/step1'
  get 'voting_wizards/step2'
  get 'voting_wizards/step3'


# voting
  post '/search' => 'votings#search'
  resources :votings do
    resources :image_items
    resources :bookmarks, only: [:create]
    delete '/bookmarks' => 'bookmarks#destroy'
    get '/init' => 'votings#init'
  end
  get 'votings/:id/delete' => 'votings#delete'
  post 'votings/:id/delete' => 'votings#destroy'
  get 'votings/:id/share' => 'votings#share'
  post 'votings/:id/share' => 'votings#send_share'
  
# classic votings
  resources :classic_votings, only: [:show, :edit] do
    get 'voting' => 'classic_votings#voting'
    get '/image_items/:id/vote_image_item' => 'classic_votings#vote_image_item'
  end

# Image Items
  resources :image_items, only: [:create, :destroy, :show, :update]
  post 'image_items/create_from_url' => 'image_items#create_from_url'

# complaints
  resources :complaints, only: [:new, :create, :show]

# friends
  ## needs clean up!
  resources :friends do
    get 'votings' => 'friends#votings'
  end
  
# friend requests
  resources :friend_requests

# categories
  resources :categories, only: [:index]

# parsing urls for assets
  resources :web_parsers, only: [:new, :create]
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
