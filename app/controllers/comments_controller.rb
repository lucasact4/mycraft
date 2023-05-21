class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.player = current_player
    if @comment.save
      flash[:success] = "O comentário foi criado com sucesso"
      redirect_to post_path(@post)
    else
      flash[:danger] = "O comentário não foi criado"
      redirect_to post_path(@post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end

end