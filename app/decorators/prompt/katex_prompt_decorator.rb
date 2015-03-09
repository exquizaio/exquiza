class Prompt::KatexPromptDecorator < ApplicationDecorator
  delegate_all

  def to_one_liner
    to_html_tag
  end

  def to_html_tag
    h.katex_tag expr: model.content
  end

end
