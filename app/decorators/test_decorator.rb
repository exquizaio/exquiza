class TestDecorator < Draper::Decorator
  delegate_all

  def answered?(question)
    responses.where(question: question).present?
  end

  def correct_percentage
    h.number_to_percentage(model.percent_correct, precision: 2)
  end

end
