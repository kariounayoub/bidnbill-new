class UsersSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :first_name, :last_name, :email, :phone_number
  attribute :full_name do |object|
    object.first_name + ' ' + object.last_name
  end
  attribute :account do |object|
    {company: object.account.company, id: object.account.id} unless object.account.nil?
  end

end
