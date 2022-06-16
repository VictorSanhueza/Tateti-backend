Rails.application.routes.draw do
	resources :players
	resources :games
	resources :games do
		member do
			get 'checkGame/:turn', to: 'games#checkGame'
		end
	end
end
