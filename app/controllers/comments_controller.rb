class CommentsController < ApplicationController
    before_action :find_post
    before_action :authenticate_user!
    

    def create
        @comment = Comment.new(comment_params)
        @comment.post = @post
        @comment.user = current_user
        if @comment.save
            flash[:success] = "Answer successfully created"
            redirect_to @post
         else
            @comments = @post.comments.order(created_at: :desc)
            render '/posts/show', status: 303
        end
        
    end

    def destroy
        @post = Post.find params[:post_id]
        @comment = Comment.find params[:id]
        if can?(:crud, @comment)
        @comment.destroy
        redirect_to post_path(@comment.post)
        flash[:success] = "Answer deleted"
        else
            redirect_to @post, alert: "Not authorized"
        end
    end

    private

    def find_post
        @post = Post.find params[:post_id]
    end

    def comment_params
        params.require(:comment).permit(:body)
    end

    
end
