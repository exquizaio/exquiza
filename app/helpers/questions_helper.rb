module QuestionsHelper
  def choice_list_items(choices)
    raise NotImplementedError
  end

  def render_prompt(prompt)
    render partial: "questions/#{prompt.model_name.collection}/show", locals: { prompt: @question.prompt }
  end
end
