class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @itemnew = Item.new

  end

  def create
    @itemnew = Item.new(item_params)
    if @itemnew.save
       redirect_to admin_item_path(@itemnew)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
       redirect_to admin_item_path(@item)
    else
       render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:genre_id,:name,:introduction,:price,:is_active,:image)
  end
end
