class Api::V1::BidsController < Api::V1::BaseController
  before_action :find_bid, only: [:select]

  def create
    bid = Bid.new(bid_params)
    authorize bid
    if bid.save
      render json: {success: true}
    else
      render json: {success: false}
    end
  end


  def select
    bill = @bid.bill
    @bid.status = 'accépté'
    if @bid.save
      bill.is_open = false
      bill.save
      render json: {success: true, bill: BillsSerializer.new(bill)}
    else
      render json: {success: false}
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:user_id, :bill_id, :price, :content)
  end

  def find_bid
    @bid = Bid.find_by_id(params[:id])
    authorize @bid
  end
end
