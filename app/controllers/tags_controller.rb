class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @books = @tag.posts.map(&:book).uniq
    @books = Kaminari.paginate_array(@books).page(params[:page]).per(10)
    @book = @books.first
  end
end
