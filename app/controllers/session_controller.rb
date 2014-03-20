class SessionController < ApplicationController

	def callback
		oauth_link = "https://github.com/login/oauth/authorize?client_id=#{ENV['CLIENT_ID']}"
		oauth_response = JSON.parse(RestClient.post("https://github.com/login/oauth/access_token", {client_id: ENV['CLIENT_ID'], client_secret: ENV['CLIENT_SECRET'], code: params["code"]}, { accept: :json }))
		client = Octokit::Client.new :access_token => parsed_response["access_token"]
		binding.pry
	end

end
