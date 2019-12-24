class UpdateBillChannel < ApplicationCable::Channel
  def subscribed
    stream_from "update_bill_#{params[:account_id]}"
  end

  def unsubscribed
    stop_all_streams
  end
end