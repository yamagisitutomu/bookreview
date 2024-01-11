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
    
     # 1. カンマ区切りの文字列を配列にする
    tag_list = params[:tag_list].split(",")
    # 2. タグ名の配列をタグの配列にする
    tags = tag_list.map { |tag_list| Tag.find_or_create_by(name: tag_list) }
    # 3. タグのバリデーションを行い、バリデーションエラーがあればPostのエラーに加える
    tags.each do |tag|
      if tag.invalid?
        @tag_list = params[:tag_list]
        @post.errors.add(:tags, tag.errors.full_messages.join("\n"))
        flash.now[:error] = '更新に失敗しました。'
        return render :edit, status: :unprocessable_entity
      end
    end

    # 重複したタグを削除
    tags.uniq!
    
    if @post.update(post_params) && @post.update!(tags: tags)
      redirect_to book_path(@book.isbn), notice: 'レビューが更新されました。'
    else
      @tag_list = params[:tag_list]
      flash.now[:error] = 'エラーが発生しました。'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    
    
    @post.destroy!
    redirect_to book_path(@post.book.isbn), notice: 'レビューが削除されました。'
  end
  
  def create
    @book = Book.find_by(isbn: params[:book_isbn])
    @post = @book.posts.build(post_params)
    @post.customer = current_customer
   
    # 1. カンマ区切りの文字列を配列にする
    tag_list = params[:tag_list].split(',')
    # 2. タグ名の配列をタグの配列にする
    tags = tag_list.map { |tag_list| Tag.find_or_initialize_by(name: tag_list) }
    # 3. タグのバリデーションを行い、バリデーションエラーがあればPostのエラーに加える
    tags.each do |tag|
      if tag.invalid?
        @tag_list = params[:tag_list]
        @post.errors.add(:tags, tag.errors.full_messages.join("\n"))
        return render :books/show, status: :unprocessable_entity
      end
    end
    
    # 重複したタグを削除
    tags.uniq!
    
    @post.tags = tags
    if @post.save
      redirect_to book_path(@book.isbn), notice: 'レビューが作成されました。'
    else
      @tag_list = params[:tag_list]
    # エラーが発生した場合の処理
      redirect_to book_path(@book.isbn), notice: 'エラーが発生しました。'
    end
  end
  
  private
  
  def authorize_user!
    # ログインユーザーが投稿の作成者でない場合、権限がない旨を示す
    unless @post.customer == current_customer
      redirect_to root_path, notice: '権限がありません。'
    end
  end
  

  def post_params
    params.require(:post).permit(:star, :review)
  end
  
  def set_book
    @book = Book.find_by(isbn: params[:book_isbn])
  end

end
