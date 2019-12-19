class AccountsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :company, :number_users_allowed

  attribute :account_users do |object|
    object.users.map{|u| UsersSerializer.new(u)}
  end
end
