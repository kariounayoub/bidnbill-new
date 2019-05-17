class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :account, optional: true
  has_many :bills

  def full_name
    "#{first_name} #{last_name}" unless first_name.nil? || last_name.nil?
  end

  USERTYPE = ['client', 'provider']
end
