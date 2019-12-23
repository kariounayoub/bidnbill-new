class RegistrationsController < Devise::RegistrationsController
  def create
    super
    resource.user_type = 'client'
    resource.save
    UserMailer.welcome(resource).deliver_later
  end

end
