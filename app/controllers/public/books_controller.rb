class Public::BooksController < ApplicationController
  def search
  end
  
  def index
    if params[:keyword]
    @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end
  
  def show
    @book = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
  end
end

  private

  def book_params
    params.require(:book).permit(:id, :star, :category)
  end