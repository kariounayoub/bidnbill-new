class BillsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :current_provider,  :price, :photo, :category,  :city, :consumption
  attribute :address, if: Proc.new {|record, params| params && params[:show_details] == true}
  attribute :zip_code, if: Proc.new {|record, params| params && params[:show_details] == true}

  attribute :bids do |object, params|
    unless  params[:show_bids] == false
      object.bids.map do |bid|
        unless bid.is_deleted
          {bid: {id: bid.id, content: bid.content, price: bid.price, status: bid.status}, account: {company: bid.account.company, id: bid.account.id}}
        end
      end
    end
  end
end
