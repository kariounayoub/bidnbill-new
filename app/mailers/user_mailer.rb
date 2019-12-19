class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.newBids.subject
  #

  def welcome(user)
    @user = user
    @greeting = greeting(user)
    mail(to: @user.email, subject: 'Bienvenue sur BidnBill')
  end

  def newBids(user)
    @user = user
    @greeting = greeting(user)
    mail(to: @user.email, subject: 'Vous avez des nouvelles offres sur votre enchères BidnBill')
  end

  def selectedBids(user, client)
    @user = user
    @client = client
    @greeting = greeting(user)
    mail(to: @user.email, subject: "#{@client.full_name} à accépter votre offre")
  end

  private

  def greeting(user)
    "Bonjour #{user.full_name}"
  end
end
