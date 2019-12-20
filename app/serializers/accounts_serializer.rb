class AccountsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :company, :number_users_allowed, :description, :phone_number, :address, :city, :country, :post_code

  attributes :picture do |object|
    object.picture.url
  end

  attribute :account_users do |object|
    object.users.map{|u| UsersSerializer.new(u)}
  end
end
