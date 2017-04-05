module Briscoe
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include Briscoe::SessionsHelper
  end
end
