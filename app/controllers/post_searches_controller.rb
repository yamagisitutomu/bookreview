class PostSearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
   # 退会していない顧客の投稿のみを取得
   @reviews = Post.joins(:customer).where(customers: { is_active: true })
   
   # 退会していないかつ指定された検索条件に合致する投稿を取得
   @reviews = @reviews.search_for(@content, @method)
  
    # ISBN に基づいて本を取得
    @book = Book.find_by(isbn: '9784863897922')
    
     # Postモデルでキーワード検索を行う
    @posts = Post.search_for(@content, @method)
    
  
    # 投稿に紐づく本を取得
    @books = @posts.map(&:book).uniq
  end
end
