Gistly::Application.routes.draw do

  root "sessions#index"
  get "sessions/index"
  get 'posts' => "posts#index"
  get "github/callback" => "sessions#callback"

end
