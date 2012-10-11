require 'action_mailer/base'

ActionMailer::Base.class_eval do
  def active_template_stack
    @active_template_stack ||= []
  end

  def active_template
    @active_template_stack.last
  end
end