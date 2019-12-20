class Api::V1::BillsController < Api::V1::BaseController
  before_action :find_user, only: [:my_bills, :create, :my_clients]
  before_action :find_bill, only: [:update]

  def my_bills
    bills = Bill.where(client: @user).includes(:bids)
    authorize bills
    render json: BillsSerializer.new(bills, {params: {show_details: true}})
  end

  def index
    bills = policy_scope(Bill).where(is_open: true).includes(:bids)
    render json: BillsSerializer.new(bills).serialized_json
  end

  def show
    bill = Bill.find_by_id(params[:id])
    authorize bill
    render json: BillsSerializer.new(bill, {params: {show_details: true}})
  end

  def create
    bill = Bill.new(bill_params)
    authorize bill
    if bill.save
      render json: {success: true, bill: BillsSerializer.new(bill, {params: {show_details: true}})}
    else
      render json: {success: false}
    end
  end

  def update
    if @bill.update(bill_params)
      @bill.bids.each {|b| b.update(needs_editing: true)}
      render json: {success: true, bill: BillsSerializer.new(@bill, {params: {show_details: true}})}
    else
      render json: {success: false}
    end
  end

  def my_clients
    bid_ids = Bid.joins(user: :account).where(status: 'accépté', accounts: {id: @user.account.id})
    authorize bid_ids
    my_bills = Bill.where(id: bid_ids.map {|bid| bid.bill.id})
    my_clients = my_bills.map{|bill| {client: UsersSerializer.new(bill.client), bill: BillsSerializer.new(bill, {params: {show_bids: false, show_details: true}}), bid: BidsSerializer.new(bill.bids.select {|b| b.user.account == current_user.account}[0])}}
    render json: my_clients
  end

  def lost_bills
    bid_ids = Bid.joins(user: :account).where(status: 'refusé', accounts: {id: current_user.account.id})
    authorize bid_ids
    bills = policy_scope(Bill).where(id: bid_ids.map {|bid| bid.bill.id})
    render json: BillsSerializer.new(bills)
  end

  private

  def bill_params
    params.require(:bill).permit(:user_id, :category_id, :price, :current_provider, :consumption, :address, :city, :payment_frequency, :calculated_consumption,
                                 :type_home, :nb_people, :surface, :hot_water, :heating, :fridge, :freezer, :oven, :dishwasher, :washer, :dryer, :pdl, :energie_verte)
  end

  def find_user
    @user = User.find_by_id(params[:user_id])
  end

  def find_bill
    @bill = Bill.find_by_id(params[:id])
    authorize @bill
  end
end
