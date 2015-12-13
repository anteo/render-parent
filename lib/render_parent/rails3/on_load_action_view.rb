require 'action_view/helpers/rendering_helper'
require 'action_view/renderer/template_renderer'

ActionView::Helpers::RenderingHelper.module_eval do
  def render_parent_template(locals = {}, &block)
    template = controller.active_template
    view_paths.exclusions << template
    locals["__rendered_depth_#{view_paths.exclusions.count}"] = true
    handlers = ActionView::Template::Handlers.extensions.select do |ext|
      ActionView::Template.handler_for_extension(ext) == template.handler
    end
    result = render(:template => template.virtual_path,
                    :formats => template.formats,
                    :handlers => handlers,
                    :locals => locals, &block)
    view_paths.exclusions.delete template
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

ActionView::PathSet.class_eval do
  attr_writer :exclusions

  def exclusions
    @exclusions ||= []
  end

  def find_all_with_exclusions(path, prefixes = [], *args)
    excluded = exclusions.map(&:identifier)
    prefixes = [prefixes] if String === prefixes
    prefixes.each do |prefix|
      paths.each do |resolver|
        templates = resolver.find_all(path, prefix, *args)
        templates.delete_if {|t| excluded.include? t.identifier} unless templates.empty?
        return templates unless templates.empty?
      end
    end
    []
  end

  alias_method_chain :find_all, :exclusions
end

ActionView::TemplateRenderer.class_eval do
  def render_template_with_active_template(template, layout_name = nil, locals = {})
    template_stack = @view.controller.respond_to?(:active_template_stack) && @view.controller.active_template_stack
    template_stack.push(template) if template_stack
    result = render_template_without_active_template( template, layout_name, locals)
    template_stack.pop if template_stack
    result
  end

  alias_method_chain :render_template, :active_template
end

ActionView::PartialRenderer.class_eval do
  def render_partial_with_active_template
    template_stack = @view.controller.respond_to?(:active_template_stack) && @view.controller.active_template_stack
    template_stack.push(@template) if template_stack
    result = render_partial_without_active_template
    template_stack.pop if template_stack
    result
  end

  alias_method_chain :render_partial, :active_template
end