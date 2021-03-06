class Api::V1::UsersController < Api::V1::BaseController
  before_action :find_user, only: [:update]

  def update
    if @user.update(user_params)
      @user.is_valid = true
      @user.save
      render json: {success: true, user: UsersSerializer.new(@user)}
    else
      render json: {success: false}
    end
  end

  def disable_user
    @user = User.find_by_id(params[:user_id])
    authorize @user
    @user.is_active = false
    if @user.save
      render json: {success: true, user: UsersSerializer.new(@user)}
    else
      render json: {success: false}
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :company, :phone_number, :email, :picture)
  end

  def find_user
    @user = User.find_by_id(params[:id])
    authorize @user
  end
end
