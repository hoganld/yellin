class ApplicationRecord < ActiveRecord::Base
  include Briscoe::ActsAsUser

  self.abstract_class = true
end
