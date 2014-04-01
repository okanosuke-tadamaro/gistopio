class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :includes_code?, :get_code, :list_tags, :identify_language

  private

  def current_user
  	User.find_by :github_access_token => session[:github_access_token]
  end

  def client
    Octokit::Client.new(access_token: current_user.github_access_token)
  end
  # def get_code(text)
  # 	text.scan(/```(.*?)```/m).flatten
  # end

  def list_tags(tags)
    tag_list = []
    tags.each do |tag|
      tag_list << tag.name
    end
    tag_list.join(" ")
  end
end
