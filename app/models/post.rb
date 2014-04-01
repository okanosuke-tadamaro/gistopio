class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tags
  validates :body, presence: true

  def self.update(github_access_token)
  	user = User.find_by(github_access_token: github_access_token)
  	client = Octokit::Client.new(access_token: github_access_token)
  	user.posts.where(sync_status: true).each do |post|
  		begin
  			gisty = client.gist(post.gist_id)
  			if post.body.gsub("\r","") != gisty.files[:"#{post.title.gsub(" ","_")}.md"].content
  				post.body = gisty.files[:"#{post.title.gsub(" ","_")}.md"].content
  				post.save
  			end
  		rescue Octokit::NotFound
  			post.sync_status = false
  			post.save
  		end
  	end
  end

  def synced?
  	gist_id.empty? ? false : true
  end

  def create_gist(client)
  	gisty = client.create_gist(:public => public_status, :files => {"#{title.gsub(" ","_")}.md" => {:content => body}})
  	self.gist_id = gisty.id
  	self.gist_url = gisty.html_url
  	save
  end

  def delete_gist(client)
  	client.delete_gist(gist_id)
  	self.gist_url = ""
  	self.gist_id = ""
  	save
  	return true
  end

  def edit_gist(client)
  	if body.gsub("\r","") != client.gist(gist_id).files[:"#{title.gsub(" ","_")}.md"].content
  		client.edit_gist(gist_id, {:files => {"#{title.gsub(" ","_")}.md" => {:content => body}}})
  		return true
  	end
  end
end
