class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :markdown, :includes_code?, :identify_language

  private

  def current_user
  	User.find_by :github_access_token => session[:github_access_token]
  end

  def markdown(text)
  	markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,　disable_indented_code_blocks: true, fenced_code_blocks: true)
  	markdown.render(text)
  end

  def get_code(text)
  	text.scan(/```(.*?)```/m)
  end

  def includes_code?(text)
		code = get_code(text)
		if code.size > 0
			true
		else
			false
		end
  end

  def identify_language(text)
  	classifier = SourceClassifier.new
  	classifier.identify(text)
  end
end
