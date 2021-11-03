# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name     = "render_parent"
  gem.homepage = "http://github.com/anteo/render-parent"
  gem.license  = "MIT"
  gem.summary  = %Q{Adds Rails "render :parent" helper, which renders template with the same name as current but higher on the view path}
  gem.email    = "anton.argirov@gmail.com"
  gem.authors  = ["Anton Argirov"]
  gem.files = Dir.glob("{lib,spec}/**/*") + %w[.ruby-gemset .ruby-version Appraisals Gemfile LICENSE.txt README.rdoc Rakefile VERSION]
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default => :spec

require 'appraisal/task'
Appraisal::Task.new