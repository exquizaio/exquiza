class Prompt::PassagePromptDecorator < ApplicationDecorator
  delegate_all

  def to_one_liner
    h.render partial: "questions/prompt/passage_prompts/one_liner", locals: { prompt: model }
  end

end
