class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:show, :edit, :update, :destroy, :show_post_history]
  
  
  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def edit
     @customer = Customer.find(params[:id])
  end

  def update
     @customer = Customer.find(params[:id])
     if @customer.update(customer_params)
       redirect_to admin_customer_path(@customer), notice: "会員情報を更新しました"
     else
       render :edit
     end
  end

  def show
  end
  
  def show_post_history
    # @customerが投稿した本の一覧を取得
    @books = @customer.posts.joins(:book).distinct.pluck(:book_id).map { |book_id| Book.find(book_id) }
    # @customerが投稿した本に関連するコメントがついた本の一覧を取得
    @books_with_comments = Book.joins(posts: :comments)
                              .where(comments: { customer_id: @customer.id })
                              .distinct
    
    # 重複を取り除いて結合
    @books += @books_with_comments
    # 一意の本のリストを作成
    unique_books = {}
    @books.each do |book|
      unique_books[book.id] ||= book
    end
    # 重複を取り除いた本のリストに変換
    @books = unique_books.values
    
    # ページネーションを適用
    @books = Kaminari.paginate_array(@books).page(params[:page]).per(5)
  # @customerをビューに渡す
    @customer = Customer.find(params[:id])
  end
  
  
  
  
  private

  def customer_params
    params.require(:customer).permit(:name,:birthdate,:gender,:email,:is_active)
  end
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
  
end