require 'sidekiq-scheduler'

class BidsMailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Bill.where(send_update_email: true).each do |bill|
      bill.days_without_mail += 1
      if bill.days_without_mail > 1
        UserMailer.newBids(bill.client).deliver
        bill.send_update_email = false
        bill.days_without_mail = 0
      end
        bill.save
    end
  end
end
