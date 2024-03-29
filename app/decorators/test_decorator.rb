class TestDecorator < Draper::Decorator
  delegate_all

  def answered?(question)
    responses.where(question: question).present?
  end

  def correct_percentage
    h.number_to_percentage(model.percent_correct, precision: 1)
  end

  def duration
    h.distance_of_time_in_words(model.started_on, model.finished_on)
  end

  def display_name
    string = "Test ##{model.id}"
    string.prepend("#{model.user.full_name} ") if h.current_user.admin?
    string
  end

  def current_test_position
    if model.finished?
      "Done"
    else
      "#{ model.position }/#{ model.test_configuration.number_of_questions }"
    end
  end

  def allowed_actions
    [].tap do |a|
      if h.current_user.admin?
        a << table_link_to('View Config', model)
        a << table_link_to('Edit Config', h.edit_test_path(model)) unless model.started?
        a << table_link_to('Destroy', model, method: :delete, data: { confirm: 'Are you sure?' })
      end
      a << table_link_to("Start Test", h.start_test_taking_test_path(model)) if !model.started? and model.user == h.current_user
      a << table_link_to("Continue Test", h.continue_test_taking_test_path(model)) if model.started? and !model.finished? and model.user == h.current_user
      a << table_link_to("Report", h.test_report_path(model)) if h.current_user.can_view_report?(model)
    end.join.html_safe
  end

  private

  def wrapped_link_to(tag=:span, *link_args)
    h.content_tag(tag) { h.link_to(*link_args) }
  end

  def table_link_to(*link_args)
    wrapped_link_to(:td, *link_args)
  end

end
