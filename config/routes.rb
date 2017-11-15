Rails.application.routes.draw do
	root 'home#index'
	resources :posts, only: [:index, :create]
	get '/auth/:provider/callback' => 'sessions#create'
	get 'logout' => 'sessions#destroy'
	get '/auth/failure', to: 'sessions#failure'

end
