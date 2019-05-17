require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "newBids" do
    mail = UserMailer.newBids
    assert_equal "Newbids", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
