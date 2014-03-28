Gistly::Application.routes.draw do

	resources :users, :only => [:show]
	resources :posts do
		resources :comments, shallow: true
	end

  root "sessions#index"
  get "sessions/index"
  get 'posts' => "posts#index"
  get "github/callback" => "sessions#callback"

end
