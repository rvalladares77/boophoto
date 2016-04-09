class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		if @post = Post.create(post_params)
			flash[:success] = "Your post has been created!"
			redirect_to posts_path
		else
			flash.now[:alert] = "Your new post couldn't be created! Please check the form"
			render :new
		end
		
	end

	def show
	end

	def edit
	end

	def update
		if @post.update(post_params)
			flash[:success] = "Post updated."
			redirect_to posts_path
		else
			flash.now[:alert] = "Update failed. Please check the form."
			render :edit
		end
	end

	def destroy
		if @post.destroy
			flash[:success] = "Post deleted."
			redirect_to root_path
		else
			flash.now[:alert] = "Ups! something went wrong. Please, Report the problem to info@boophoto.com."
			redirect_to posts_path
 		end
	end

	private

	def post_params
		params.require(:post).permit(:image, :caption)
	end

	def set_post
		@post = Post.find(params[:id])
	end

end
