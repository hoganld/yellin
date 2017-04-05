module Yellin
  class Engine < ::Rails::Engine
    isolate_namespace Yellin

    initializer 'yellin.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Yellin::SessionsHelper
      end
    end
  end
end
