class Admin::BooksController < ApplicationController
  before_action :authenticate_admin!
  
  
  def show
    @book = Book.find_by(isbn: params[:isbn])
    # レビューのページネーション
    @posts = @book.posts.joins(:customer).where(customers: { is_active: true }).page(params[:page]).per(5)
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to book_path(@post.book.isbn), notice: 'レビューが削除されました。'
  end
  
end