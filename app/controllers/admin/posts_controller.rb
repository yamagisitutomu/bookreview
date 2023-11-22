class Admin::PostsController < ApplicationController
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_book_path(@post.book.isbn), notice: 'レビューが削除されました。'
  end
  
   private

  def post_params
    params.require(:post).permit(:star, :review)
  end
  
end
