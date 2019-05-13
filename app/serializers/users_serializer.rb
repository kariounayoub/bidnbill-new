class UsersSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :first_name, :last_name, :email, :account
  attribute :full_name do |object|
    object.first_name + ' ' + object.last_name
  end

end
