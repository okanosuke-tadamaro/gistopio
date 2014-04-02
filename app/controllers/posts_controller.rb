class PostsController < ApplicationController
  
	def index
		@posts = current_user.posts.all
    @post = current_user.posts.new
	end

	def show
		@posty = current_user.posts.find(params[:id])
		@comments = @posty.comments.all
		@post = current_user.posts.new
	end

	def new
		@post = current_user.posts.new
	end

	def create
		@post = current_user.posts.create(post_params)
		
		### Adding Tags
		params[:tags].split.each do |tag|
			if Tag.exists?(name: tag)
				record = Tag.find_by(name: tag)
				@post.tags << record
			else
				@post.tags.create(name: tag)
			end
		end
		
		### Create Gist
		if @post.sync_status
			@post.create_gist(client)
		end

		redirect_to posts_path
	end

	def edit
		@post = current_user.posts.find(params[:id])
	end

	def update
		@post = current_user.posts.find(params[:id])
		@post.update(post_params)

		### Update Tags
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

		### Update Gist
		if @post.sync_status && @post.synced? == false
			gist = @post.create_gist(client)
		elsif @post.synced? && @post.sync_status == false
			@post.delete_gist(client)
		else
			@post.edit_gist(client)
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
		@post = current_user.posts.new
	end

	private

	def post_params
		params.require('post').permit(:title, :body, :sync_status, :public_status, :tags)
	end

end
