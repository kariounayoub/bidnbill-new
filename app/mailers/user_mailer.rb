class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.newBids.subject
  #
  def newBids(user)
    @user = user
    @greeting = greeting(user)
    mail(to: @user.email, subject: 'Vous avez des nouvelles offres sur votre abonnement BillSelector')
  end

  def selectedBids(user)
    @user = user
    @greeting = greeting(user)
    mail(to: @user.email, subject: "Une ou plusieurs de vos offres ont été sélectionées!")
  end

  private

  def greeting(user)
    "Bonjour #{user.full_name}"
  end
end
