class Api::V1::AccountsController < Api::V1::BaseController
  before_action :find_account

  def new_user
    user = User.new(user_params)
    user.password = SecureRandom.alphanumeric
    user.account = @account
    user.user_type = 'provider'
    if user.save
      render json: {success: true, user: UsersSerializer.new(user)}
      user.send_reset_password_instructions
    else
      render json: {success: false}
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone_number)
  end

  def find_account
    @account = Account.find(params[:id])
    authorize @account
  end
end