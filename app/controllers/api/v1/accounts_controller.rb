class Api::V1::AccountsController < Api::V1::BaseController
  before_action :find_account, only: [:update]

  def new_user
    @account = Account.find(params[:account_id])
    authorize @account
    user = User.new(user_params)
    user.password = SecureRandom.alphanumeric
    user.account = @account
    user.user_type = 'provider'
    if user.save
      render json: {success: true, user: UsersSerializer.new(user)}
      user.send_reset_password_instructions
    else
      render json: {success: false, messages: user.errors.full_messages}
    end
  end

  def update
    if @account.update(account_params)
      render json: {success: true, account: AccountsSerializer.new(@account)}
    else
      render json: {success: false}
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone_number)
  end

  def account_params
    params.require(:account).permit(:company, :description, :picture, :phone_number, :address, :city, :country, :post_code)
  end

  def find_account
    @account = Account.find(params[:id])
    authorize @account
  end
end