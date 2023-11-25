class Admin::CommentsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]
  
  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to admin_book_path(@post.book.isbn), notice: 'コメントが削除されました。'
  end
  
  private

  def comment_params
    params.require(:comment).permit(:body)
  end
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
end
