class NotificationsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :bid_id, :seen, :category, :content

  attributes :bill do |object|
    object.bid.bill.id
  end
end
