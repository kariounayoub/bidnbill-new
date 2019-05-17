# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/newBids
  def newBids
    user = User.first
    UserMailer.newBids(user)
  end

end
