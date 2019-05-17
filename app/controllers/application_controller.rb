class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  include Pundit
  after_action :verify_authorized, except: :index, unless: :skip_pundit?

  def skip_pundit?
    devise_controller?
  end

  def after_sign_in_path_for(resource)
    return client_dashboard_path if resource.user_type == 'client'
    return provider_dashboard_path if resource.user_type == 'provider'
    root_path
  end
end
