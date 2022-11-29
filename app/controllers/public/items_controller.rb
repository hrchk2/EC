class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items =@genre.items.all
    else
      @items = Item.all
    end
  end 
  
  def show
     @item = Item.find(params[:id])
     @genres = Genre.all
  end
end
