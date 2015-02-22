class Prompt::ParagraphPromptDecorator < ApplicationDecorator
  delegate_all

  def to_one_liner
    h.truncate(model.content, length: 30)
  end

end
