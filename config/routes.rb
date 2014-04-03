Gistly::Application.routes.draw do

	root "sessions#index"
	
	get "/posts/tags/:tag" => "posts#tag_view"

	resources :users, :only => [:show]
	resources :posts do
		resources :comments, shallow: true
	end

  get "sessions/index"
  get "github/callback" => "sessions#callback"
  get "/logout" => "sessions#destroy"

  get "/:username" => "posts#other_user"

end
