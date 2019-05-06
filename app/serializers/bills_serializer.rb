class BillsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :current_provider, :address, :price, :photo, :category, :consumption, :city, :zip_code, :created_at
end
