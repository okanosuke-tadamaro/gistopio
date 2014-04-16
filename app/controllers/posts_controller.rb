class PostsController < ApplicationController

	before_action :signed_in?
	before_action :authorize_post, only: [:update, :destroy]

	def index
		@post = new_post
		@posts = current_user.posts.all
		dates = @posts.map { |post| post.updated_at.to_date.to_s }.uniq
		@dated_posts = dates.inject(Array.new) { |array, date| array << [date, @posts.map { |post| post if post.updated_at.to_date.to_s == date }.compact] }
	end

	def show
		@posty = Post.find(params[:id])
		@comments = @posty.comments.all
		@post = new_post
	end

	def create
		@post = current_user.posts.create(post_params)
		@post.create_title if @post.title == ""
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
		@posty.delete_gist(client) if @posty.sync_status
		@posty.destroy
		redirect_to posts_path
	end

	def tag_view
		@tag = Tag.find_by(name: params[:tag])
		@posts = @tag.posts.where(user_id: current_user.id)
		@post = current_user.posts.new
	end

	def user_view
		@user = User.find_by(username: params[:username])
		@posts =  @user.posts.where(public_status: true)
		@post = current_user.posts.new
	end

	private

	def post_params
		params.require('post').permit(:title, :body, :sync_status, :public_status, :tags)
	end

end
