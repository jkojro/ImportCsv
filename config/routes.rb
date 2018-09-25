Spree::Core::Engine.add_routes do

  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  resources :products do
    collection { post :import}
  end
end
