# frozen_string_literal: true

# The BootstrapBreadcrumbsBuilder is a Bootstrap compatible breadcrumb builder.
# It provides basic functionalities to render a breadcrumb navigation according to Bootstrap 4's conventions.
#
# You can use it with the :builder option on render_breadcrumbs:
#     <%= render_breadcrumbs builder: ::BootstrapBreadcrumbsBuilder %>

class BootstrapBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @context.content_tag(:nav, aria: { label: "breadcrumb" }) do |_|
      @context.content_tag(:ol, class: "breadcrumb") do
        @elements.collect do |element|
          render_element(element)
        end.join.html_safe
      end
    end
  end

  def render_element(element)
    current = @context.current_page? compute_path(element)

    @context.content_tag(:li, class: "breadcrumb-item #{"active" if current}") do
      @context.link_to_unless_current(compute_name(element), compute_path(element), element.options)
    end
  end
end
