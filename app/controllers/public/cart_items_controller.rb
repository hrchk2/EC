class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.all
    @total_price = 0
  end

  def create
    cart_item = current_customer.cart_items.new(cart_item_params)
    current_cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if params[:cart_item][:amount].blank?
       redirect_back(fallback_location: root_path)
    elsif current_cart_item.present?
        current_cart_item.amount += params[:cart_item][:amount].to_i
        current_cart_item.save
        cart_item.delete
        redirect_to cart_items_path
    else
        cart_item.save
        redirect_to cart_items_path
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
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
