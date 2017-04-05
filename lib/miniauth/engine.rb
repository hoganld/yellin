module Briscoe
  class Engine < ::Rails::Engine
    isolate_namespace Briscoe

    initializer 'briscoe.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Briscoe::SessionsHelper
      end
    end
  end
end
