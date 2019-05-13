class BillsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :current_provider,  :price, :photo, :category,  :city
  attribute :bids do |object|
    object.bids.map do |bid|
      unless bid.is_deleted
        {bid: {id: bid.id, content: bid.content, price: bid.price, status: bid.status}, account: {company: bid.account.company, id: bid.account.id}}
      end
    end
  end
end
