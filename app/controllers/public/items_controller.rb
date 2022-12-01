class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    if  params[:keyword]
       @keyword = Item.search(params[:keyword])
       @items = @keyword.all
    elsif params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items =@genre.items.all
    else
      @items = Item.all
    end
  end 
  
  def show
     @item = Item.find(params[:id])
     @genres = Genre.all
     @cart_item = CartItem.new
  end
end
