class Admin::BooksController < ApplicationController
  before_action :authenticate_admin!
  
  
  def show
    @book = Book.find_by(isbn: params[:isbn])
    @post = Post.new(book: @book)
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to book_path(@post.book.isbn), notice: 'レビューが削除されました。'
  end
  
  
end
