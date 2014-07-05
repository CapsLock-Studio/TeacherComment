require 'test_helper'

class RegistrationMailTest < ActionMailer::TestCase
  test "reciever" do
    mail = RegistrationMail.reciever
    assert_equal "Reciever", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
