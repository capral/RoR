class PostsController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_author, only: [:edit, :update, :destroy]


  def index
    @posts = Post.reverse_order(:desc).published.all
  end

  def unpublished
    @posts = Post.reverse_order(:desc).unpublished.all
    render :index
  end


  def show
    @comment = Comment.new
  end


  def new
    @post = Post.new
  end


  def edit
  end


  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Пост был успешно создан.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Пост был успешно обновлён.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Пост был успешно удалён.' }
      format.json { head :no_content }
    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end


    def post_params
      params.require(:post).permit(:title, :body, :published, category_ids: [])
    end

   def check_author
     unless current_user.author_of?(@post)
       redirect_to :root, alert: "Вы не имеете права тут этого делать"
     end
   end
end
