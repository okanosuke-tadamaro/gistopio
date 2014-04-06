class CommentsController < ApplicationController

	before_action :authorize_comment, only: [:destroy]

	def index
		@post = Post.find(params[:post_id])
		@comments = @post.comments.all
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(comment_params)
		@comment.author_id = current_user.id
		@comment.save
		redirect_to post_path(@post)
	end

	def destroy
		@comment = Comment.find(params[:id])
		@post = @comment.post
		@comment.destroy
		redirect_to @post
	end

	private

	def comment_params
		params.require(:comment).permit(:body, :author_id)
	end

end
