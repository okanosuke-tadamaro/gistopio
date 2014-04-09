Gistly::Application.routes.draw do

	root "sessions#index"
	
	get "/posts/tags/:tag" => "posts#tag_view"

	resources :users, :only => [:show]
	resources :posts, :only => [:index, :show, :create, :update, :destroy] do
		resources :comments, shallow: true
	end

  get "sessions/index"
  get "github/callback" => "sessions#callback"
  get "/logout" => "sessions#destroy"
  get "/:username" => "posts#user_view"

end
