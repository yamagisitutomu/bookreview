class PostSearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    #退会した人の物を省く
    @reviews = Post.joins(:customer).merge(Customer.active).where(...)
    
    # ISBN に基づいて本を取得
    @book = Book.find_by(isbn: '9784863897922')
    
     # Postモデルでキーワード検索を行う
    @posts = Post.search_for(@content, @method)
    
  
    # 投稿に紐づく本を取得
    @books = @posts.map(&:book).uniq
  end
end
