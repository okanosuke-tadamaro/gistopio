class PostsController < ApplicationController

	before_action :signed_in?
	before_action :authorize_post, only: [:update, :destroy]

	def index
		@posts = current_user.posts.all
    @post = new_post
	end

	def show
		@posty = Post.find(params[:id])
		@comments = @posty.comments.all
		@post = new_post
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

		if @post.sync_status && @post.synced? == false
			@post.create_gist(client)
		elsif @post.synced? && @post.sync_status == false
			@post.delete_gist(client)
		elsif @post.synced? && @post.sync_status == true
			@post.edit_gist(client)
		end

		redirect_to posts_path
	end

	def destroy
		@posty = current_user.posts.find(params[:id])
		
		if @posty.user.id == current_user.id
			@posty.comments.destroy_all
			@posty.destroy
			redirect_to posts_path
		else
			redirect_to posts_path
		end
	end

	def tag_view
		@tag = Tag.find_by(name: params[:tag])
		@posts = @tag.posts.where(user_id: current_user.id)
		@post = current_user.posts.new
	end

	def other_user
		@user = User.find_by(username: params[:username])
		@posts =  @user.posts.where(public_status: true)
		@post = current_user.posts.new
	end

	private

	def post_params
		params.require('post').permit(:title, :body, :sync_status, :public_status, :tags)
	end

end
