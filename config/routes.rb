Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  devise_for :users

  # You can have the root of your site routed with "root"
  root 'votings#index'

  # voting wizard routes
  get 'voting_wizards/step1'
  get 'voting_wizards/step2'
  get 'voting_wizards/step3'

  resources :image_items, only: [:create, :destroy]

  
  resources :votings do
    resources :voting_complaints, only: [:new, :create]
    resources :image_items
    resources :bookmarks, only: [:create]
    delete '/bookmarks' => 'bookmarks#destroy'
  end

  get 'votings/:id/delete' => 'votings#delete'
  post 'votings/:id/delete' => 'votings#destroy'
  get 'votings/:id/share' => 'votings#share'
  post 'votings/:id/share' => 'votings#send_share'
  
  resources :classic_votings, only: [:show, :edit]


  ## needs clean up!
  resources :friends do
    get 'votings' => 'friends#votings'
  end
  
  resources :friend_requests

  resources :users, only: [:update, :destroy, :show, :edit] do 
    resources :friends
    resources :friend_requests
    resources :bookmarks, only: [:index, :destroy]
  end

  resources :categories, only: [:index]

  # some helpers
  get '/layouts/shared/close_canvas'

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
