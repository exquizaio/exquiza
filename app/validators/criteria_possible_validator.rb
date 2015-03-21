class CriteriaPossibleValidator < ActiveModel::Validator
  def validate(record)
    config = record.test_configuration
    unless config.is_criteria_possible?
      record.errors[:base] << "Only #{config.found_question_count} questions found for this criteria."
    end
  end
end
