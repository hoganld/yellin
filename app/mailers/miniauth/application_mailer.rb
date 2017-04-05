module Briscoe
  class ApplicationMailer < ActionMailer::Base
    default from: Briscoe.default_from_address
    layout 'mailer'
  end
end
