class PostsController < ApplicationController
    before_action :find_post, only: [:edit, :update, :show, :destroy]
# ============================CREATE=======================================
    def new
        #direct to new page
        @post = Post.new
    end

    def create
        #create new post
        @post = Post.new(post_params)
        if @post.save
            flash[:success] = "Question successfully created"
            redirect_to @post
          else
            flash[:error] = "Something went wrong"
            render 'new', status: 303
        end
    end


# ============================READ=======================================
    def index
        #display all posts
        @posts = Post.order(created_at: :desc)
        @count = 0
    end

    def show
        @comments = @post.comments.order(created_at: :desc)
        @comment = Comment.new
        #to view one specific post
    end

    # ============================UPDATE=======================================
    def edit
        #direct to edit page
    end

    def update
        if @post.update(post_params)
            flash[:success] = "Post successfully updated"
            redirect_to @post
        else
            flash[:error] = "Something went wrong"
            render :edit, status: 303
        end

    end



    # ============================DELETE=======================================

    def destroy
        @post.destroy
        redirect_to posts_path

    end

    private   


    def find_post
        @post = Post.find params[:id]
      end


    def post_params
        params.require(:post).permit(:title, :body)
      end
    

end
