module QuestionsHelper
  def choice_list_items(choices)
    raise NotImplementedError
  end

  def render_prompt(prompt)
    raise NotImplementedError
  end
end
