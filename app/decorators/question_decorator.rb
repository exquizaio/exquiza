class QuestionDecorator < Draper::Decorator
  delegate_all
  decorates_association :prompt

  def tag_pills
    h.unordered_list class: "tag-list--pill" do
      model.tags.collect {|c|
        tag_pill(c)
      }.join.html_safe
    end
  end

  def tag_pill(tag, node: :li, **options)
    h.content_tag node, tag, class: "tag-pill", **options
  end

  def subject_pills
    h.unordered_list class: "subject-list--pill" do
      model.tags.collect {|c|
        tag_pill(c)
      }.join.html_safe
    end
  end

  def subject_pill(tag, node: :li, **options)
    h.content_tag node, tag, class: "subject-pill", **options
  end
end
