class PostsController < ApplicationController
  
	def index
		@posts = current_user.posts.all
    @post = current_user.posts.new
	end

	def show
		@post = current_user.posts.find(params[:id])
		@body = markdown(@post.body)
		@comments = @post.comments.all
	end

	def new
		@post = current_user.posts.new
	end

	def create
		@post = current_user.posts.create(post_params)
		params[:tags].split.each do |tag|
			if Tag.exists?(name: tag)
				record = Tag.find_by(name: tag)
				@post.tags << record
			else
				@post.tags.create(name: tag)
			end
		end
		redirect_to posts_path
	end

	def edit
		@post = current_user.posts.find(params[:id])
	end

	def update
		@post = current_user.posts.find(params[:id]).update(post_params)
		redirect_to posts_path
	end

	def destroy
		@post = current_user.posts.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private

	def post_params
		params.require('post').permit(:title, :body, :sync_status, :public_status, :tags)
	end

end
