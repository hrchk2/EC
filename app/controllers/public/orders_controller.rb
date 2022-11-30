class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def confirm
    @cart_items = current_customer.cart_items
    @total_price = 0
    @order = Order.new(order_params)
    if    params[:order][:address_number] == "1"
          @order = Order.new(order_params)
          @order.postal_code = current_customer.postal_code
          @order.address = current_customer.address
          @order.name = current_customer.full_name
    elsif params[:order][:address_number] == "2"
          @address = Ships.find(params[:order][:ship_id])
          @order.postal_code = @address.postal_code
          @order.address = @address.address
          @order.name = @address.name
    elsif params[:order][:address_number] == "3"
          if  (@order.postal_code || @order.address || @order.name ).empty?
              redirect_to new_order_path
          end
    else
      redirect_to new_order_path
    end
    @order.shipping_cost = 800
end
  
  def thanks
  end
  
  def create
    
  end
  
  def index
  end
  
  def show
  end
  
  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
  
end