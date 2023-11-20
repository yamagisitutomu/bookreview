class Public::PostsController < ApplicationController
  before_action :set_book, only: [:create]
  
  def index
  end

  def show
  end

  def edit
    @book = Book.find_by(isbn: params[:book_isbn])
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to book_path(@post.book.isbn), notice: 'レビューが更新されました。'
    else
      render :edit
    end
  end

  def destroy
  @post = Post.find(params[:id])
  @post.destroy
  redirect_to book_path(@post.book.isbn), notice: 'レビューが削除されました。'
  end
  
  def create
    @post = @book.posts.build(post_params)
    @post.customer = current_customer
    
    if @post.save
      redirect_to book_path(@book.isbn), notice: 'レビューが作成されました。'
    else
    # エラーが発生した場合の処理
      render 'public/books/show', locals: { book: @book }
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:star, :review)
  end
  
  def set_book
    @book = Book.find_by(isbn: params[:book_isbn])
  end

end
