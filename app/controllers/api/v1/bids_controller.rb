class Api::V1::BidsController < Api::V1::BaseController
  before_action :find_bid, only: [:select, :update]

  def create
    bid = Bid.new(bid_params)
    authorize bid
    if bid.save
      notification = Notification.create(bid: bid, user: bid.bill.client, category: 'new bid', seen: false, content: "#{bid.user.account.company} vous a fait une offre")
      render json: {success: true}
      ActionCable.server.broadcast("update_bill_#{bid.bill.client.id}", {})
    else
      render json: {success: false}
    end
  end

  def update
    if @bid.update(bid_params)
      @bid.update(needs_editing: false)
      render json: {success: true}
      ActionCable.server.broadcast("update_bill_#{@bid.user.account.id}", {}) unless bid_params[:client_status].nil?
      ActionCable.server.broadcast("update_bill_#{@bid.bill.client.id}", {})  if bid_params[:client_status].nil?
    else
      render json: {success: false}
    end
  end


  def select
    bill = @bid.bill
    @bid.status = 'accépté'
    @bid.client_status = "Nouveau"
    @bid.methode_contact = bid_params[:methode_contact]
    if @bid.save
      notification = Notification.create(bid: @bid, user: @bid.user, category: 'accepted bid', seen: false, content: "#{@bid.bill.client.full_name} a accépté votre offre")
      # UserMailer.selectedBids(@bid.user, @bid.bill.client).deliver_later
      otherBids = bill.bids.reject {|b| b == @bid}
      otherBids.each do |b|
         b.update(status: 'refusé')
         ActionCable.server.broadcast("update_bill_#{b.user.account.id}", {})
      end
      bill.is_open = false
      bill.save
      render json: {success: true, bill: BillsSerializer.new(bill)}
      ActionCable.server.broadcast("update_bill_#{@bid.user.account.id}", {})
      ActionCable.server.broadcast("update_bill_#{bill.client.id}", {})
    else
      render json: {success: false}
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:user_id, :bill_id, :price, :content, :methode_contact, :client_status)
  end

  def find_bid
    @bid = Bid.find_by_id(params[:id])
    authorize @bid
  end
end
