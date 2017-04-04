module Miniauth
  class Engine < ::Rails::Engine
    isolate_namespace Miniauth

    initializer 'miniauth.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Miniauth::SessionsHelper
      end
    end
  end
end
