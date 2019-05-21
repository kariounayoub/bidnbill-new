class BillsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :current_provider, :photo, :category,  :city, :consumption, :is_open, :price, :payment_frequency
  attribute :address, if: Proc.new {|record, params| params && params[:show_details] == true}
  attribute :latitude, if: Proc.new {|record, params| params && params[:show_details] == true}
  attribute :longitude, if: Proc.new {|record, params| params && params[:show_details] == true}
  attribute :zip_code, if: Proc.new {|record, params| params && params[:show_details] == true}

  attribute :standardized_price do |object|
    case object.payment_frequency
    when 'annuelle'
      (object.price / 12).round(2)
    when 'semestrielle'
      (object.price / 6).round(2)
    when 'mensuelle'
      object.price.round(2)
    else
      object.price.round(2)
    end
  end

  attribute :bids do |object, params|
    unless  params[:show_bids] == false
      object.bids.map do |bid|
        unless bid.is_deleted
          {bid: {id: bid.id, content: bid.content, price: bid.price, status: bid.status, needs_editing: bid.needs_editing}, account: {company: bid.account.company, id: bid.account.id, user: bid.user_id}}
        end
      end
    end
  end
end
