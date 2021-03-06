Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'home#index'

  namespace :home do
    get 'index'
    get 'locked'
    get 'search'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  resources :users, only: [] do
    resources :stacks, only: :index
    resources :reviews, only: :index
  end
  resources :reviews
  resources :stacks, only: [:index, :create, :destroy] do
    delete :with_game, on: :collection
  end
  resources :games, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :characters, only: [:index, :show]
  resources :roles, only: [:index, :show]
  resources :appearances, only: [:index, :show]
  resources :creators, only: [:index, :show]
  resources :subgenres, only: [:index, :show]
  resources :brands, only: [:index, :show]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
