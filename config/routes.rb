Gistly::Application.routes.draw do

	resources :users, :only => [:show] do
		resources :posts, shallow: true do
			resources :comments, shallow: true
		end
	end

  root "sessions#index"
  get "sessions/index"
  get 'posts' => "posts#index"
  get "github/callback" => "sessions#callback"

end
