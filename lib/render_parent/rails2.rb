require 'action_view/base'

ActionView::Base.class_eval do
  def render_parent_template(local_assigns = {}, &block)
    view_paths.exclusions << template
    result = render(:file => template.to_s, :locals => local_assigns, &block)
    view_paths.exclusions.delete template
    result
  end

  def render_with_parent(options = {}, local_assigns = {}, &block)
    if options == :parent
      render_parent_template(local_assigns, &block)
    else
      render_without_parent(options, local_assigns, &block)
    end
  end

  alias_method_chain :render, :parent
end

ActionView::PathSet.class_eval do
  attr_writer :exclusions

  def exclusions
    @exclusions ||= []
  end

  def find_template(original_template_path, format = nil, html_fallback = true)
    return original_template_path if original_template_path.respond_to?(:render)
    template_path = original_template_path.sub(/^\//, '')

    each do |load_path|
      if format && (template = load_path["#{template_path}.#{I18n.locale}.#{format}"]) && !exclusions.include?(template)
        return template
      # Try the default locale version if the current locale doesn't have one
      # (i.e. you haven't translated this view to German yet, but you have the English version on hand)
      elsif format && (template = load_path["#{template_path}.#{I18n.default_locale}.#{format}"]) && !exclusions.include?(template)
        return template
      elsif format && (template = load_path["#{template_path}.#{format}"]) && !exclusions.include?(template)
        return template
      elsif (template = load_path["#{template_path}.#{I18n.locale}"]) && !exclusions.include?(template)
        return template
      elsif (template = load_path["#{template_path}.#{I18n.default_locale}"]) && !exclusions.include?(template)
        return template
      elsif (template = load_path[template_path]) && !exclusions.include?(template)
        return template
      # Try to find html version if the format is javascript
      elsif format == :js && html_fallback && (template = load_path["#{template_path}.#{I18n.locale}.html"]) && !exclusions.include?(template)
        return template
      elsif format == :js && html_fallback && (template = load_path["#{template_path}.#{I18n.default_locale}.html"]) && !exclusions.include?(template)
        return template
      elsif format == :js && html_fallback && (template = load_path["#{template_path}.html"]) && !exclusions.include?(template)
        return template
      end
    end

    return ActionView::Template.new(original_template_path) if File.file?(original_template_path)

    raise ActionView::MissingTemplate.new(self, original_template_path, format)
  end
end