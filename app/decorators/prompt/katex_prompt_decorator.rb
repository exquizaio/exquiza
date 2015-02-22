class Prompt::KatexPromptDecorator < ApplicationDecorator
  delegate_all

  def to_one_liner
    h.katex_tag expr: model.content
  end

end
