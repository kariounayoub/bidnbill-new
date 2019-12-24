class UpdateBillsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "update_bills"
  end

  def unsubscribed
    stop_all_streams
  end
end