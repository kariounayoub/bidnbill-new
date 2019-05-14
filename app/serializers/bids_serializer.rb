class BidsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :status,  :content, :price

end
