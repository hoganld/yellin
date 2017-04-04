module Miniauth
  class ApplicationMailer < ActionMailer::Base
    default from: Miniauth.default_from_address
    layout 'mailer'
  end
end
