class StaticPagesController < ApplicationController

  before_action :sign_in_required, only: :secret

  def home
  end

  def secret
  end

end
