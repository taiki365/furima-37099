class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :@item = Item.find(params[:id]), only: [:show, :edit, :update]
  def index
    @items = Item.all.order(id: 'DESC')
  end

  def new
    @items = Item.new
  end

  def create
    @items = Item.new(item_params)
    if @items.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    unless  current_user.id == @item.user_id
      redirect_to action: :index
    end
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :profile, :category_id, :status_id, :delivery_fee_id, :prefecture_id,
                                 :delivery_date_id, :price).merge(user_id: current_user.id)
  end
end
