class Api::V1::BillsController < Api::V1::BaseController
  before_action :find_user, only: [:my_bills, :create]

  def my_bills
    @bills = Bill.where(client: @user)
    authorize @bills
    bills = @bills.map{|bill| {bill: BillsSerializer.new(bill), info: {address: bill.address, consumption: bill.consumption, zip_code: bill.zip_code}}}
    render json: bills
  end

  def index
    @bills = policy_scope(Bill)
    render json: BillsSerializer.new(@bills).serialized_json
  end

  def show
    @bill = Bill.find_by_id(params[:id])
    authorize @bill
    render json: {bill: BillsSerializer.new(@bill), info: {address: @bill.address,  consumption: @bill.consumption, zip_code: @bill.zip_code}}
  end

  def create
    @bill = Bill.new(bill_params)
    if @bill.save
      @user.update(user_params)
      bill = {bill: BillsSerializer.new(@bill), info: {address: @bill.address,  consumption: @bill.consumption, zip_code: @bill.zip_code}}
      render json: {success: true, bill: bill, user: UsersSerializer.new(@user)}
    else
      render json: {success: false}
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:user_id, :category_id, :price, :current_provider, :consumption, :address)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :company, :phone_number)
  end

  def find_user
    @user = User.find_by_id(params[:user_id])
  end

end
