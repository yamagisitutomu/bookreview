class Public::BooksController < ApplicationController
  def new
  end

  def index
    if params[:keyword]
    @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end
  
  def show
    @book = Book.find(params[:id])
  end
end

  private

  def book_params
    params.require(:book).permit(:star, :category)
  end