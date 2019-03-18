# frozen_string_literal: true

class BulmaBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @context.content_tag(:nav, class: "breadcrumb", aria: { label: "breadcrumb" }) do |_|
      @context.content_tag(:ul) do
        @elements.collect do |element|
          render_element(element)
        end.join.html_safe
      end
    end
  end

  def render_element(element)
    current = @context.current_page? compute_path(element)

    @context.content_tag(:li, class: "#{"is-active" if current}") do
      @context.link_to(compute_name(element), compute_path(element), element.options)
    end
  end
end
