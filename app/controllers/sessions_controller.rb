class SessionsController < ApplicationController
	
	def index
		@oauth_link = User.oauth_link
	end
	
	def callback
		oauth_response = User.oauth_response(params["code"])
		client = User.new_client(oauth_response).user
		session[:github_access_token] = oauth_response["access_token"]

		unless User.exists?(username: client.login)
			User.create(username: client.login, github_access_token: oauth_response["access_token"])
		end

		# flash[:notice] = "Successfully signed in"
		redirect_to posts_path
	end

end
