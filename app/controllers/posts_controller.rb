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
		Tag.create_tags(@post, params[:tags])
		@post.create_gist(client) if @post.sync_status
		redirect_to posts_path
	end

	def update
		@posty = current_user.posts.find(params[:id])
		@posty.update(post_params)
		Tag.update_tags(@posty, params[:tags])
		Post.update_gists(@posty, client)
		redirect_to posts_path
	end

	def destroy
		@posty = current_user.posts.find(params[:id])
		@posty.comments.destroy_all
		@posty.destroy
		redirect_to posts_path
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
