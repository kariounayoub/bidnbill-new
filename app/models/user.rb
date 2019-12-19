class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :account, optional: true
  has_many :bills
  has_many :notifications

  validates :phone_number, format: { with: /((\+|00)33|0)\s*[1-9](?:[\s.-]*\d{2}){4}/}, allow_blank: true


  def full_name
    "#{first_name} #{last_name}" unless first_name.nil? || last_name.nil?
  end

  USERTYPE = ['client', 'provider']
end
