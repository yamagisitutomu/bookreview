class Public::PostsController < ApplicationController
  before_action :set_book, only: [:create]
  before_action :authenticate_customer!, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @book = Book.find_by(isbn: params[:book_isbn])
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @book = @post.book # @book を @post の関連する本にセット
    
    # tag_list が params[:post] から取得されるようにする
    tag_list = params[:post][:tag_list].split(',')
    
    # 既存の post_tags を削除
    @post.post_tags.destroy_all

    tag_list.each do |tag_name|
    tag = Tag.find_or_create_by(name: tag_name.strip)
    PostTag.create(post: @post, tag: tag)
    end
    
    
    if @post.update(post_params)
      redirect_to book_path(@post.book.isbn), notice: 'レビューが更新されました。'
    else
      flash[:error] = 'エラーが発生しました。'
      render :edit
    end
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
  
  def create
    @book = Book.find_by(isbn: params[:book_isbn])
    @post = @book.posts.build(post_params)
    @post.customer = current_customer
    
    tag_list = params[:post][:tag_list].split(',').map(&:strip)
    
    if @post.save
      tag_list.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      PostTag.create(post: @post, tag: tag)
      end
      redirect_to book_path(@book.isbn), notice: 'レビューが作成されました。'
    else
    # エラーが発生した場合の処理
      redirect_to book_path(@book.isbn), notice: 'エラーが発生しました。'
    end
  end
  
  private
  
  def authorize_user!
    @post = Post.find(params[:id])

    # ログインユーザーが投稿の作成者でない場合、権限がない旨を示す
    unless @post.customer == current_customer
      redirect_to root_path, notice: '権限がありません。'
    end
  end
  

  def post_params
    params.require(:post).permit(:star, :review, tag_list: [])
  end
  
  def set_book
    @book = Book.find_by(isbn: params[:book_isbn])
  end

end
