require 'rails'
require 'action_view'

if Rails::VERSION::MAJOR >= 6
  require 'render_parent/rails6'
elsif Rails::VERSION::MAJOR >= 5
  require 'render_parent/rails5'
elsif Rails::VERSION::MAJOR >= 3
  require 'render_parent/rails3'
elsif Rails::VERSION::MAJOR == 2
  require 'render_parent/rails2'
end
