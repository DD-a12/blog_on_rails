class PostsController < ApplicationController
    before_action :find_post, only: [:edit,:update,:show, :destroy]
    before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :update]
    before_action :authorize?, only: [:edit, :update, :destroy]
    def index
        @posts=Post.all 
    end
    def new
        @post=Post.new 
    end
    def show
        @comment = Comment.new
        @comments = @post.comments.order(created_at: :desc)
    end
    def create
        @post=Post.new post_params
        if @post.save
            flash[:notice] = 'Post Created Successfully'
            redirect_to post_path(@post.id)
        else
            render :new
        end
    end
    def update
        if @post.update post_params
            flash[:notice] = 'post updated Successfully'
            redirect_to post_path(@post.id)
        else
            render :edit
        end
    end
    def edit
        find_post
    end
    def destroy
        find_post
        @post.destroy
        redirect_to root_path
    end
    private
    def find_post
        @post=Post.find params[:id]
    end
    def post_params
        params.require(:post).permit(:title, :body)
    end
    def authorize! 
        unless can?(:crud, @post)
            redirect_to root_path, flash[:alert] = 'Not Authorized' 
        end
    end
end
