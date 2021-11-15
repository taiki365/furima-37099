class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @Items = Item.all
  end

  def new
    @Items = Item.new
  end

  def create
    @Items = Item.new(item_params)
    if @Items.save
      redirect_to root_path
    else
      @Items = Item.new(item_params)
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :profile, :category_id, :status_id, :delivery_fee_id, :prefecture_id,
                                 :delivery_date_id, :price).merge(user_id: current_user.id)
  end
end
