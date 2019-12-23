class BidsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :status,  :content, :price, :methode_contact, :client_status

end
