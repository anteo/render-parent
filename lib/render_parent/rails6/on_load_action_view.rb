ActionView::Base.class_eval do
  def render_parent_template(locals = {}, &block)
    template = @current_template
    view_paths.excluded(template) do
      locals["__rendered_depth_#{view_paths.exclusions.count}"] = true

      handlers = ActionView::Template::Handlers.extensions.select do |ext|
        ActionView::Template.handler_for_extension(ext) == template.handler
      end
      render template: template.virtual_path,
             formats:  template.format,
             handlers: handlers,
             locals:   locals, &block
    end
  end

  def render_with_parent(options = {}, locals = {}, &block)
    if options == :parent
      render_parent_template(locals, &block)
    else
      render_without_parent(options, locals, &block)
    end
  end

  alias_method :render_without_parent, :render
  alias_method :render, :render_with_parent
end

ActionView::PathSet.class_eval do
  attr_writer :exclusions

  def excluded(template)
    exclusions << template
    yield
  ensure
    exclusions.delete template
  end

  def exclusions
    @exclusions ||= []
  end

  def find_all_with_exclusions(path, prefixes = [], *args)
    excluded = exclusions.map(&:identifier)
    prefixes = [prefixes] if String === prefixes
    prefixes.each do |prefix|
      paths.each do |resolver|
        templates = resolver.find_all(path, prefix, *args)
        templates.delete_if { |t| excluded.include? t.identifier } unless templates.empty?
        return templates unless templates.empty?
      end
    end
    []
  end

  alias_method :find_all_without_exclusions, :find_all
  alias_method :find_all, :find_all_with_exclusions
end

ActionView::LookupContext.class_eval do
  def initialize_with_exclusions(view_paths, details = {}, prefixes = [])
    initialize_without_exclusions(view_paths, details, prefixes)
    @view_paths.exclusions = view_paths.exclusions if view_paths.is_a?(ActionView::PathSet)
  end

  alias_method :initialize_without_exclusions, :initialize
  alias_method :initialize, :initialize_with_exclusions
end

