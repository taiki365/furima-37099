class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @buy_delivery = BuyDelivery.new
    @item = Item.find(params[:item_id])
    redirect_to root_path unless current_user.id == @item.user.id
    if @item.buy.present?
      redirect_to root_path
    end
  end

  def create
    @buy_delivery = BuyDelivery.new(buy_params)
    @item = Item.find(params[:item_id])
    if @buy_delivery.valid?
      Payjp.api_key = 'sk_test_e746a81594e9de41aafb3a5a'
      Payjp::Charge.create(
        amount: @item.price,
        card: buy_params[:token],
        currency: 'jpy'
      )
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
end
