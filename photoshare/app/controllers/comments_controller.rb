class CommentsController < ApplicationController
	before_action :set_post
	before_action :owned_post, only: [:edit, :update, :destroy]
	def create
		@comment = @post.comments.build(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			respond_to do |format|
				format.html { redirect_to root_path }
				format.js
			end
		else
			flash[:alert] = "Check the comment form, something is wrong"
			render root_path
		end
	end

	def destroy
		@comment = @post.comments.find(params[:id])

		if @comment.user_id == current_user.id
			@comment.delete
			respond_to do |format|
				format.html { redirect_to root_path}
				format.js
			end
		end
	end

	private

		def comment_params
			params.require(:comment).permit(:content)
		end

		def set_post
			@post = Post.find(params[:post_id])
		end

		def owned_post
			unless current_user == @post.user 
				flash[:alert] = "That post doesn't belong to you!"
				redirect_to root_path
			end
		end
	 
end
