if Rails::VERSION::MAJOR >= 3
  require 'render_parent/rails3'
elsif Rails::VERSION::MAJOR == 2
  require 'render_parent/rails2'
end