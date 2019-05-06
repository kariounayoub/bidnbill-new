class Api::V1::BillsController < Api::V1::BaseController
  before_action :find_user, only: [:index]

  def index
    @bills = Bill.where(client: @user)
    render json: BillsSerializer.new(@bills).serialized_json
  end

  private

  def find_user
    @user = User.find_by_id(params[:id])
  end

end
