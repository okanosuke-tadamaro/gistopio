class SessionsController < ApplicationController
	
	def index
		@oauth_link = User.oauth_link
	end
	
	def callback
		oauth_response = User.oauth_response(params["code"])
		client = User.new_client(oauth_response).user
		session[:github_access_token] = oauth_response["access_token"]

		unless User.exists?(username: client.login)
			User.create(username: client.login, github_access_token: oauth_response["access_token"], avatar_url: "#{client.avatar_url}#{client.gravatar_id}")
		end

		Post.update(session[:github_access_token])

		redirect_to posts_path
	end

	def destroy
		session[:github_access_token] = nil
		redirect_to posts_path
	end

end
