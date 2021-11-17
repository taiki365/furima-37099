class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

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
    @items = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :profile, :category_id, :status_id, :delivery_fee_id, :prefecture_id,
                                 :delivery_date_id, :price).merge(user_id: current_user.id)
  end
end
