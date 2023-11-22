class Admin::CustomersController < ApplicationController
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
    @customer = Customer.find(params[:id])
  end
  
  private

  def customer_params
    params.require(:customer).permit(:name,:birthdate,:gender,:email,:is_active)
  end
end