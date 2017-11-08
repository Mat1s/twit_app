Rails.application.routes.draw do
	root 'home#index'
	resources :posts, only: [:show, :index, :new, :create, :destroy]

	get '/users/:id' => "users#show"
	get '/auth/:provider/callback' => 'sessions#create'
	get 'logout' => 'sessions#destroy'
end
