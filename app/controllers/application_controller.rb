class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :list_tags, :block_user, :check_user

  private

  def current_user
  	User.find_by :github_access_token => session[:github_access_token]
  end

  def client
    Octokit::Client.new(access_token: current_user.github_access_token)
  end

  def list_tags(tags)
    tag_list = []
    tags.each do |tag|
      tag_list << tag.name
    end
    tag_list.join(" ")
  end

  def new_post
    current_user.posts.new
  end

  def block_user
    
  end

  def check_user

  end
end
