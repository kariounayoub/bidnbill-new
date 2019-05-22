require 'sidekiq-scheduler'

class SelectedBidsMailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Bid.where(provider_notification_sent: false, status: 'accépté').each do |bid|
        bid.user.days_since_last_provider_email += 1
      if bid.user.days_since_last_provider_email > 1
        UserMailer.selectedBids(bid.user).deliver
        bid.provider_notification_sent = true
        bid.user.days_since_last_provider_email = 0
      end
        bid.save
        bid.user.save
    end
  end
end
