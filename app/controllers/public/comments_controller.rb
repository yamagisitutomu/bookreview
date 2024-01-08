class Public::CommentsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]
  before_action :authorize_comment_owner, only: [:destroy]
  
  def create
    @comment = @post.comments.build(comment_params)
    @comment.customer = current_customer

    if @comment.save
      redirect_to book_path(@post.book.isbn), notice: 'コメントが追加されました。'
    else
      # エラーが発生した場合の処理
      redirect_to book_path(@post.book.isbn), notice: 'コメントが見つかりませんでした。'
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to book_path(@post.book.isbn), notice: 'コメントが削除されました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def authorize_comment_owner
    @comment = @post.comments.find_by(id: params[:id])

    unless @comment && @comment.customer == current_customer
      redirect_to book_path(@post.book.isbn), alert: '権限がありません。'
    end
  end
end