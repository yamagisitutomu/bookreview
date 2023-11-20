class Public::CommentsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]
  
  def create
    @comment = @post.comments.build(comment_params)
    @comment.customer = current_customer

    if @comment.save
      redirect_to book_path(@post.book.isbn), notice: 'コメントが追加されました。'
    else
      # エラーが発生した場合の処理
      render 'public/books/show', locals: { book: @book }
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
  
end