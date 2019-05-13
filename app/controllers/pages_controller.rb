class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  skip_after_action :verify_authorized, only: [:home]

  def home
  end

  def client_dashboard
    authorize current_user
    @client = UsersSerializer.new(current_user).serialized_json
    @categories = Category.all.map { |c| {id: c.id, name: c.name}}.to_json
  end

  def provider_dashboard
    authorize current_user
    @provider = UsersSerializer.new(current_user).serialized_json
  end

  private
end
