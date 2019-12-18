class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  include Pundit
  after_action :verify_authorized, except: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autorisé a éffectuer cette action."
    redirect_to(root_path)
  end

  def skip_pundit?
    devise_controller?
  end

  def after_sign_in_path_for(resource)
    return client_dashboard_path if resource.user_type == 'client'
    return provider_dashboard_path if resource.user_type == 'provider'
    root_path
  end

  def after_sign_up_path_for(resource)
    return users_edit_client_path if resource.user_type == 'client'
    return users_edit_provider_path if resource.user_type == 'provider'
    root_path
  end
end
