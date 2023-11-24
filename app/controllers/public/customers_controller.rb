class Public::CustomersController < ApplicationController
   before_action :authenticate_customer!, only: [:show, :edit, :update, :withdraw, :index]
   before_action :authorize_user!, only: [:edit, :update, :withdraw, :check]
   
  def index
    #退会している会員を表示しない
     @customers = Customer.where(is_active: true).page(params[:page]).per(10)
  end
  
  
  def show
    @customer = Customer.find(params[:id])
    # 投稿が存在する本を収得
    @books = @customer.posts.map(&:book).uniq
    # ページネーション
    @books = Kaminari.paginate_array(@books).page(params[:page]).per(5)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:update]="お客様の情報更新に成功しました。"
      redirect_to customer_path(@customer.id)
    else
     render  'edit'
    end 
  end

  def check
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    # is_activeカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
  
  def authorize_user!
    @customer = Customer.find(params[:id])

    # ログインユーザーが編集しようとしている顧客の所有者でない場合、権限がないとして適切な処理を行う
    unless @customer.id == current_customer.id
      redirect_to root_path, notice: '権限がありません。'
    end
  end
  
  
  

  def customer_params
    params.require(:customer).permit(:name, :birthdate, :gender, :email)
  end


end