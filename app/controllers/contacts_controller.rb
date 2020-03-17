class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  skip_after_action :verify_authorized, only: [:new, :create]
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:notice] = 'Votre message à bien été envoyé, nous vous recontacterons dans les plus brefs délais'
      @contact = Contact.new
      redirect_to new_contact_path
    else
      flash[:error] = 'Une erreur est survenu, veuillez réessayer'
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :company, :message, :phone)
  end
end
