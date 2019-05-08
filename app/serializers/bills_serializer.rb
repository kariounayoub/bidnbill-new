class BillsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :current_provider, :address, :price, :photo, :category, :consumption, :city, :zip_code
  attribute :bids do |object|
    object.bids.map {|bid| {bid: bid, user: bid.user, account: bid.account}}
  end
end
