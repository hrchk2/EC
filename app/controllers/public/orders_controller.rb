class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.shipping_cost = 800
    @total_price = 0
    if    params[:order][:address_number] == "1"
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
  end
  
  def create
     @order = Order.new(order_params)
     @order.customer_id = current_customer.id
     @cart_items = current_customer.cart_items
     if @order.save
          @cart_items.each do |cart_item|
            order_item = OrderItem.new
            order_item.order_id = @order.id
            order_item.item_id = cart_item.item_id
            order_item.price = cart_item.item.price_add_tax
            order_item.amount = cart_item.amount
            order_item.save
          end
        @cart_items.destroy_all
        redirect_to orders_thanks_path
     else
        @total_price = 0
        @order.shipping_cost = 800
        render :confirm
     end
  end
  
  def thanks
  end
  
  
  def index
  end
  
  def show
  end
  
  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name,:shipping_cost,:total_payment )
  end
  
end