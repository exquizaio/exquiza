class Prompt::KatexPromptDecorator < ApplicationDecorator
  delegate_all

  def to_one_liner
    "Image Prompt"
  end

end
