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

end
