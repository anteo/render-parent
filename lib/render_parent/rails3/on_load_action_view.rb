require 'action_view/helpers/rendering_helper'
require 'action_view/renderer/template_renderer'

ActionView::Helpers::RenderingHelper.module_eval do
  def render_parent_template(locals = {}, &block)
    template = controller.active_template
    saved_view_paths = view_paths.paths.dup
    view_paths.paths.delete_if {|p| template.identifier.start_with? p.to_s}
    result = render({:file => template.virtual_path}, locals, &block)
    view_paths.paths.replace(saved_view_paths)
    result
  end

  def render_with_parent(options = {}, locals = {}, &block)
    if options == :parent
      render_parent_template(locals, &block)
    else
      render_without_parent(options, locals, &block)
    end
  end

  alias_method_chain :render, :parent
end

ActionView::TemplateRenderer.class_eval do
  def render_template_with_active_template(template, layout_name = nil, locals = {})
    template_stack = @view.controller.try(:active_template_stack)
    template_stack.push(template) if template_stack
    result = render_template_without_active_template( template, layout_name, locals)
    template_stack.pop if template_stack
    result
  end

  alias_method_chain :render_template, :active_template
end

ActionView::PartialRenderer.class_eval do
  def render_partial_with_active_template
    template_stack = @view.controller.try(:active_template_stack)
    template_stack.push(@template) if template_stack
    result = render_partial_without_active_template
    template_stack.pop if template_stack
    result
  end

  alias_method_chain :render_partial, :active_template
end