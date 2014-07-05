# encoding: UTF-8
class RegistrationMail < ActionMailer::Base
  default from: "michael34435@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.registration_mail.reciever.subject
  #
  def reciever(user, user_id, verify_code)
    @uri = ENV['APP_URI'] + '/verify/' + user_id.to_s + '?verify_code=' + verify_code.to_s

    mail to: user, :subject => '恭喜您完成註冊，請驗證信箱'
  end
end
