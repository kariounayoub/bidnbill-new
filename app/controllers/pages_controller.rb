class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  skip_after_action :verify_authorized, only: [:home]

  def home
  end

  def client_dashboard
    authorize current_user
    @client = UsersSerializer.new(current_user).serialized_json
  end

  def provider_dashboard
  end

  private
end
