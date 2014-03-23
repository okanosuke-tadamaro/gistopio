class User < ActiveRecord::Base
	has_many :posts

	def self.oauth_link
		return "https://github.com/login/oauth/authorize?client_id=#{ENV['CLIENT_ID']}"
	end

	def self.oauth_response(code)
		return JSON.parse(RestClient.post("https://github.com/login/oauth/access_token", {client_id: ENV['CLIENT_ID'], client_secret: ENV['CLIENT_SECRET'], code: code}, { accept: :json }))
	end

	def self.new_client(response)
		return Octokit::Client.new :access_token => response["access_token"]
	end

end
