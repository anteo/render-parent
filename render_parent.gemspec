# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: render_parent 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "render_parent".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Anton Argirov".freeze]
  s.date = "2021-11-03"
  s.email = "anton.argirov@gmail.com".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".ruby-gemset",
    ".ruby-version",
    "Appraisals",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/rails/init.rb",
    "lib/render_parent.rb",
    "lib/render_parent/rails/on_load_action_controller.rb",
    "lib/render_parent/rails/on_load_action_mailer.rb",
    "lib/render_parent/rails2.rb",
    "lib/render_parent/rails3.rb",
    "lib/render_parent/rails3/on_load_action_view.rb",
    "lib/render_parent/rails5.rb",
    "lib/render_parent/rails5/on_load_action_view.rb",
    "lib/render_parent/rails6.rb",
    "lib/render_parent/rails6/on_load_action_view.rb",
    "spec/fixtures/path1/template.html.erb",
    "spec/fixtures/path2/template.html.erb",
    "spec/fixtures/path3/template.html.erb",
    "spec/lib/render_parent_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/anteo/render-parent".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.9".freeze
  s.summary = "Adds Rails \"render :parent\" helper, which renders template with the same name as current but higher on the view path".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, [">= 2.3.0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.3.0", "< 2.0"])
      s.add_development_dependency(%q<jeweler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 2.3.0"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.3.0", "< 2.0"])
      s.add_dependency(%q<jeweler>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 2.3.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.3.0", "< 2.0"])
    s.add_dependency(%q<jeweler>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
  end
end

