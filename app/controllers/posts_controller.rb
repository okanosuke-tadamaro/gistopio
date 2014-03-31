class PostsController < ApplicationController
  
	def index
		@posts = current_user.posts.all
    @post = current_user.posts.new
	end

	def show
		@post = current_user.posts.find(params[:id])
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
		
		if @post.sync_status
			gist = @post.create_gist(current_user.github_access_token)
			@post.gist_url = gist
			@post.save
		end

		redirect_to posts_path
	end

	def edit
		@post = current_user.posts.find(params[:id])
	end

	def update
		@post = current_user.posts.find(params[:id])
		@post.update(post_params)
		@post.tags.each do |post_tag|
			@post.tags.delete(post_tag) if params[:tags].include?(post_tag.name) == false
		end
		params[:tags].split.each do |tag|
			if Tag.exists?(name: tag) && @post.tags.exists?(name: tag) == false
				record = Tag.find_by(name: tag)
				@post.tags << record
			elsif Tag.exists?(name: tag) == false
				@post.tags.create(name: tag)
			end
		end
		redirect_to posts_path
	end

	def destroy
		@post = current_user.posts.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	def tag_view
		@tag = Tag.find_by(name: params[:tag])
		@posts = @tag.posts.where(user_id: current_user.id)
	end

	private

	def post_params
		params.require('post').permit(:title, :body, :sync_status, :public_status, :tags)
	end

end
