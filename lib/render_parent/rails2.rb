require 'action_view/base'

ActionView::Base.class_eval do
  def render_parent_template(local_assigns = {}, &block)
    saved_view_paths = view_paths.dup
    view_paths.delete_if {|p| p.to_s == template.load_path.to_s}
    result = render({:file => template.to_s}, local_assigns, &block)
    view_paths.replace(saved_view_paths)
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