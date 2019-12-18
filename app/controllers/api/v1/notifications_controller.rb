class Api::V1::NotificationsController < Api::V1::BaseController
  before_action :find_notification

  def seen
    @notification.seen = true
    if @notification.save
      render json: {success: true}
    else
      render json: {success: false}
    end
  end

  private
  def find_notification
    @notification = Notification.find(params[:id])
    authorize @notification
  end
end