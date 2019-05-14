class Api::V1::BidsController < Api::V1::BaseController

  def create
    bid = Bid.new(bid_params)
    if bid.save
      render json: {success: true}
    else
      render json: {success: false}
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:user_id, :bill_id, :price, :content)
  end
end
