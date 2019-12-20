class AccountsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :company, :number_users_allowed, :description, :phone_number, :address, :city, :country, :post_code

  attributes :picture do |object|
    object.picture.url
  end

  attribute :account_users do |object, params|
    object.users.where.not(is_active: false, id: params[:current_user].id).map{|u| UsersSerializer.new(u)}
  end
end
