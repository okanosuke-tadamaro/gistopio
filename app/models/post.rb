class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tags

  def create_gist(github_access_token)
  	client = Octokit::Client.new(access_token: github_access_token)
  	gist = client.create_gist(:public => public_status, :files => {"#{title}.md" => {:content => body}})
  	return gist[:url]
  end
end
