module Miniauth
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include Miniauth::SessionsHelper
  end
end
