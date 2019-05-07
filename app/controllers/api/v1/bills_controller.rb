class Api::V1::BillsController < Api::V1::BaseController
  before_action :find_user, only: [:index]

  def index
    @bills = Bill.where(client: @user)
    authorize @bills
    render json: BillsSerializer.new(@bills).serialized_json
  end

  def show
    @bill = Bill.find_by_id(params[:id])
    authorize @bill
    render json: BillsSerializer.new(@bill).serialized_json
  end

  private

  def find_user
    @user = User.find_by_id(params[:user_id])
  end

end
