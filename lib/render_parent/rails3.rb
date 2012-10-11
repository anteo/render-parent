require 'rails'

module RenderParent
  class Railtie < Rails::Railtie
    initializer "render_parent.initialize" do
      ActiveSupport.on_load(:action_controller) do
        require 'render_parent/rails3/on_load_action_controller'
      end
      ActiveSupport.on_load(:action_mailer) do
        require 'render_parent/rails3/on_load_action_mailer'
      end
      ActiveSupport.on_load(:action_view) do
        require 'render_parent/rails3/on_load_action_view'
      end
    end
  end
end