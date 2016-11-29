Rails.application.routes.draw do

  resources :teams
  get 'search/results'

  resources :comments, only: [:index, :new, :create]

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", registrations: 'registrations' }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get '/profile' => 'users#profile'
  post '/users/make_admin/:id' => 'users#make_admin'
  post '/users/demote_admin/:id' => 'users#demote_admin'
  get '/submissions/upvote/:id' => 'submissions#upvote'
  post '/submissions/upvote/:id' => 'submissions#upvote'
  get '/submissions/downvote/:id' => 'submissions#downvote'
  post '/submissions/downvote/:id' => 'submissions#downvote'
  get '/challenges/upvote/:id' => 'challenges#upvote'
  post '/challenges/upvote/:id' => 'challenges#upvote'
  get '/challenges/downvote/:id' => 'challenges#downvote'
  post '/challenges/downvote/:id' => 'challenges#downvote'

  post '/teams/join/:id' => 'teams#join'
  post '/teams/leave/:id' => 'teams#leave'

  resources :submissions do
    resources :users do
    end
    resources :comments do
    end
  end
  resources :challenges do
    resources :users do
    end
    resources :submissions do
    end
  end
  resources :users do
    resources :challenges do
    end
    resource :submissions do
    end
   end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'welcome#index'

  # match ':controller(/:action(/:id))', :via => [:get, :post]


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
  match ':controller(/:action(/:id))', :via => :get
end
