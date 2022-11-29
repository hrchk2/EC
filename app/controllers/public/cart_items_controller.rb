class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total_price = 0
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @cart_items=current_customer.cart_items.all
    @cart_items.each do |cart_item|
      if @cart_item.amount == nil
        redirect_back(fallback_location: root_path)
      elsif  cart_item.item_id == @cart_item.item_id
        cart_item.amount += @cart_item.amount
        @cart_item.delete
        cart_item.save
      else
        @cart_item.save
      end
      redirect_to  cart_items_path
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end
