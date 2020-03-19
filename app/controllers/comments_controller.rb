class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]
    before_action :authorized!, only: [:destroy]

    def create
        @post = Post.find params[:post_id]
        @comment = Comment.new params.require(:comment).permit(:body)
        @comment.post = @post
        if @comment.save
            flash[:notice] = 'comment Created Successfully'
            redirect_to post_path(@post)
        else
            @comments = @post.comments.order(created_at: :desc)
            render 'posts/show'
        end
    end
    
    def destroy
        @comment=Comment.find params[:id]
        @comment.destroy
        redirect_to post_path(@comment.post)
    end

    private

    def authorized!
        unless can? :crud, @comment
            flash[:alert] = "Not authorized"
        end
    end
end
