class ApplicationRecord < ActiveRecord::Base
  include Miniauth::ActsAsUser

  self.abstract_class = true
end
