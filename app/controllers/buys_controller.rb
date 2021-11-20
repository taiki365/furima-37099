class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_buy, only: [:index, :create]

  def index
    @buy_delivery = BuyDelivery.new
    redirect_to root_path if current_user.id == @item.user.id
    if @item.buy.present?
      redirect_to root_path
    end
  end

  def create
    @buy_delivery = BuyDelivery.new(buy_params)
    if @buy_delivery.valid?
      set_payjp
      @buy_delivery.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buy_params
    params.require(:buy_delivery).permit(:zip_code, :prefecture_id, :city, :address, :building_name, :telephone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_buy
    @item = Item.find(params[:item_id])
  end

  def set_payjp
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: buy_params[:token],
        currency: 'jpy'
      )
  end
end
