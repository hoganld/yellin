module Yellin
  class ApplicationMailer < ActionMailer::Base
    default from: Yellin.default_from_address
    layout 'mailer'
  end
end
