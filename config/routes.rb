Spree::Core::Engine.add_routes do
  resources :products do
    collection { post :import}
  end
end
