class Notification < ApplicationRecord
  CATEGORIES = ['new bid', 'accepted bid']

  belongs_to :user
  belongs_to :bid, optional: true
  validates :category, inclusion: { in: CATEGORIES }

  after_create do |notification|
    ActionCable.server.broadcast(
      "notifications_#{notification.user.id}",
      notification: NotificationsSerializer.new(notification)
    )
  end
end
