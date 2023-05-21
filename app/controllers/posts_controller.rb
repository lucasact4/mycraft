class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :set_error, only: [:new, :edit]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    I18n.locale = 'pt'
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.paginate(page: params[:page], per_page: 5)
  end

  def new
  end

  def create
    @post = Post.new(post_params)
    @post.player = current_player
    if @post.save
      flash[:success] = "A postagem foi criada com sucesso!"
      redirect_to post_path(@post)
    else
      if @post.errors.any?
        @errors = true
        @count = @post.errors.count
        @error = @post.errors.messages
      end
      redirect_to new_post_path(post: @post, errors: @errors, count: @count, error: @error)
    end
  end

  def edit
    @post = Post.find(params[:id]) if params[:id]
  end

  def update
    if @post.update(post_params)
      flash[:success] = "A postagem foi atualizada com sucesso!"
      redirect_to post_path(@post)
    else
      if @post.errors.any?
        @errors = true
        @count = @post.errors.count
        @error = @post.errors.messages
      end
      redirect_to edit_post_path(post: @post, errors: @errors, count: @count, error: @error)
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Postagem excluída com sucesso!"
    redirect_to posts_path
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def set_error
      @error = params[:error]
      @count = params[:count]
      @errors = params[:errors] == 'true'
      @post = params[:post] || Post.new
    end
  
    def post_params
      params.require(:post).permit(:name, :description, item_ids: [])
    end

    def require_same_user
      @post = Post.find(params[:id])
      if current_player != @post.player and !current_player.admin?
        flash[:danger] = "Você só pode editar ou excluir suas próprias prostagens!"
        redirect_to posts_path
      end
    end

end