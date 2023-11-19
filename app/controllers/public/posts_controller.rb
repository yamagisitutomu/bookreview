class Public::PostsController < ApplicationController
  before_action :set_book, only: [:create]
  
  def index
  end

  def show
  end

  def edit
  end
  
  def create
    # @book = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
    @post = @book.posts.build(post_params)
    @post.customer = current_customer
    if @post.save
      redirect_to book_path(params[:isbn]), notice: 'レビューが作成されました。'
    else
    # エラーが発生した場合の処理
    render 'public/books/show'
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:star, :review)
  end
  
  def set_book
    @book = Book.find_by(isbn: params[:isbn])
  end

end
