class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :find_user, only: [:client_dashboard, :provider_dashboard]

  def home
  end

  def client_dashboard
  end

  def provider_dashboard
  end

  private

  def find_user
    @user = User.find(params[:id])
    authorize @user
  end
end
