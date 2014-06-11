MyStackoverflow::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  resources :users, only: [:show, :index]
  concern :commentable do
    resources :comments, only: [:new, :create]
  end

  concern :voteable do
    post 'votes/up' => 'votes#up', as: :up_vote
    post 'votes/down' => 'votes#down', as: :down_vote
  end

  resources :questions do
    concerns [ :commentable, :voteable ]
    resources :answers, only: [:create, :edit, :update, :destroy]
    collection do
      get 'unanswered', to: 'questions#index', sort_by: 'unanswered'
      get 'voted', to: 'questions#index', sort_by: 'voted'
      get 'popular',    to: 'questions#index', sort_by: 'popular'
      get 'newest',    to: 'questions#index', sort_by: 'newest'
    end
  end
  resources :answers, only: [], concerns: [ :commentable, :voteable ]
  resources :comments, only: [:edit, :update, :destroy]
  patch 'answers/:question_id/:id/best' => 'answers#best', as: :best_answer
  get 'tags/:tag' => 'questions#index', as: :tag
  get 'tags' => 'tags#index', as: :tags
  root 'questions#index'

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
