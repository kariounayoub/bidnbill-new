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
    if bill.save
      @user.update(user_params)
      render json: {success: true, bill: BillsSerializer.new(bill, {params: {show_details: true}}), user: UsersSerializer.new(@user)}
    else
      render json: {success: false}
    end
  end

  def update
    if @bill.update(bill_params)
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

  private

  def bill_params
    params.require(:bill).permit(:user_id, :category_id, :price, :current_provider, :consumption, :address, :city)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :company, :phone_number)
  end

  def find_user
    @user = User.find_by_id(params[:user_id])
  end

  def find_bill
    @bill = Bill.find_by_id(params[:id])
    authorize @bill
  end
end
