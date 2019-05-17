require 'sidekiq-scheduler'

class SendMailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Bill.all.each do |bill|
      bill.days_without_mail += 1
      if bill.send_update_email && bill.days_without_mail > 0
        UserMailer.newBids(bill.client).deliver
        bill.send_update_email = false
        bill.days_without_mail = 0
      end
        bill.save
    end
  end
end
