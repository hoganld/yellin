module Yellin
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include Yellin::SessionsHelper
  end
end
