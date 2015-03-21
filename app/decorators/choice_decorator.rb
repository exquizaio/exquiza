class ChoiceDecorator < Draper::Decorator
  delegate_all
  
  def length_css_class
    model.content.length > 20 ? "Choice--paragraph" : "Choice--text"
  end
end
