class CommentsController < ApplicationController
	before_action :set_post

	def create
		@comment = @post.comments.build(comment_params)
		@comment.user_id = current_user.id

		#logger.debug {"Person attributes hash: #{@comment.attributes.inspect}"}
		if @comment.save
			respond_to do |format|
          		format.html {redirect_to root_path}
          		format.js
			end
		else
			flash[:alert] = "Check the comment form, something went wrong."
			render root_path
		end
	end


	def destroy
		@comment = @post.comments.find(params[:id])

		@comment.destroy
		flash[:success] = "Your comment has been deleted :("
		redirect_to root_path
		#else
	   	#	flash[:alert] = "Damn!!! something went wrong"
		#	redirect_to root_path
		#end

	end


	private

	def comment_params
		params.require(:comment).permit(:content)
	end

	def set_post
		@post = Post.find(params[:post_id])		
	end
end
