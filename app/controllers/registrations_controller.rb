class RegistrationsController < Devise::RegistrationsController
  def create
    super
    resource.user_type = 'client'
    resource.save
  end
end
