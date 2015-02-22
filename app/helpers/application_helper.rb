module ApplicationHelper
  def html_list(type: :ul, **options)
    content_tag type, **options do
      yield
    end
  end
  alias_method :unordered_list, :html_list

  def katex_tag(expr:, **options)
    content_tag :span, "Katex Loading...", data: { expr: expr }, **options
  end
end
