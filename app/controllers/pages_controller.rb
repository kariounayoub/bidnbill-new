class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :a_propos, :donnes_personnels, :mentions_legals, :cookies_page]
  skip_after_action :verify_authorized, only: [:home, :a_propos, :donnes_personnels, :mentions_legals, :cookies_page]

  def home
  end

  def client_dashboard
    authorize current_user
    @client = UsersSerializer.new(current_user).serialized_json
    @categories = Category.all.map { |c| {id: c.id, name: c.name}}.to_json
    redirect_to users_edit_client_path if !current_user.is_valid && users_edit_client_path != request.env['REQUEST_URI']
  end

  def provider_dashboard
    authorize current_user
    @provider = UsersSerializer.new(current_user).serialized_json
    @account = AccountsSerializer.new(current_user.account, {params: {current_user: current_user}}).serialized_json
  end

  def a_propos
  end

  def donnes_personnels
  end

  def mentions_legals
  end

  def cookies_page
  end
end
