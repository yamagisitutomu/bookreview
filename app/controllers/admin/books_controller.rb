class Admin::BooksController < ApplicationController
  before_action :authenticate_admin!
  
  
  def show
    @book = Book.find_by(isbn: params[:isbn])
    # レビューのページネーション
    @posts = @book.posts.joins(:customer).page(params[:page]).per(5)
  end
  
  def destroy
    @post = Post.find(params[:id])
    # レビューに関連するタグを削除
    @post.tags.destroy_all

    # タグが他の投稿と関連していない場合、タグを削除
    @post.tags.each do |tag|
       tag.destroy if tag.posts.empty?
    end
    @post.destroy
    redirect_to book_path(@post.book.isbn), notice: 'レビューが削除されました。'
  end
  
end