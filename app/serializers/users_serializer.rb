class UsersSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :first_name, :last_name, :email, :phone_number, :is_valid, :company, :account_admin
  attribute :picture do |object|
    object.picture.url
  end
  attribute :full_name do |object|
    object.first_name.nil? || object.last_name.nil? ? '' : object.first_name + ' ' + object.last_name
  end
  attribute :account do |object|
    {company: object.account.company, id: object.account.id} unless object.account.nil?
  end
  attribute :notifications do |object|
    object.notifications.where(seen: false).map{|n| NotificationsSerializer.new(n)}
  end

end
