require 'spec_helper'

RSpec.describe :render_parent do
  class Controller < ActionController::Base
    layout false

    prepend_view_path('spec/fixtures/path1')
    prepend_view_path('spec/fixtures/path2')
    prepend_view_path('spec/fixtures/path3')

    def self.build
      if Rails::VERSION::MAJOR < 5
        build_4
      else
        build_5
      end
    end

    def self.build_4
      request  = ActionDispatch::TestRequest.new
      response = ActionDispatch::Response.new

      instance          = new
      instance.request  = request
      instance.response = response
      instance
    end

    def self.build_5
      request = ActionDispatch::TestRequest.create

      instance = new
      instance.set_request! request
      instance.set_response! make_response!(request)
      instance
    end
  end

  before(:all) do
  end

  let(:controller) { Controller.build }

  it 'should render templates in defined order' do
    result = controller.render(template: 'template', locals: { variable: 'Test variable' })
    result = result.first if result.is_a?(Array)
    expect(result).to eq(<<~EOS)
      Test variable
      Contents of path1/template.html.erb
      Contents of path2/template.html.erb
      Contents of path3/template.html.erb
    EOS
  end
end
