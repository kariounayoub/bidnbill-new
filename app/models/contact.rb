class Contact < ApplicationRecord
  validates_presence_of :name, :email
  validates :email, presence: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }
  validates :phone, format: { with: /((\+|00)212|0)\s*[1-9](?:[\s.-]*\d{2}){4}/ }, allow_blank: true

  def parse_number
    phone_number = phone.match(/((\+|00)212|0)(\s*[1-9](?:[\s.-]*\d{2}){4})/)
    "0" + phone_number[3].gsub(' ', '').gsub('.', '').gsub('-', '')
  end
end
