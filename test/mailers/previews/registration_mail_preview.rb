# Preview all emails at http://localhost:3000/rails/mailers/registration_mail
class RegistrationMailPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/registration_mail/reciever
  def reciever
    RegistrationMail.reciever
  end

end
