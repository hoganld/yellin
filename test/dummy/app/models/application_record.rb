class ApplicationRecord < ActiveRecord::Base
  include Yellin::ActsAsUser

  self.abstract_class = true
end
