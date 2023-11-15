class Public::BooksController < ApplicationController
  def search
  end
  
  def index
    if params[:keyword]
    @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end
  
  def show
    @book = Book.find_by(id: params[:id])
  end
end

  private

  def book_params
    params.require(:book).permit(:star, :category)
  end