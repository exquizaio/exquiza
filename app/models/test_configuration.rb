# == Schema Information
#
# Table name: test_configurations
#
#  id                  :integer          not null, primary key
#  number_of_questions :integer
#  min_difficulty      :integer
#  max_difficulty      :integer
#  min_grade_level     :integer
#  max_grade_level     :integer
#  test_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class TestConfiguration < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :subjects

  belongs_to :test

  validates_numericality_of :min_difficulty, less_than_or_equal_to: ->(test) { test.max_difficulty }
  validates_numericality_of :max_difficulty, greater_than_or_equal_to: ->(test) { test.min_difficulty }

  validates_numericality_of :min_grade_level, less_than_or_equal_to: ->(test) { test.max_grade_level }
  validates_numericality_of :max_grade_level, greater_than_or_equal_to: ->(test) { test.min_grade_level }


  def difficulty_range=(range, min: range.min, max: range.max)
    update_attributes(min_difficulty: min, max_difficulty: max)
  end

  def difficulty_range
    min_difficulty..max_difficulty
  end

  def grade_level_range=(range, min: range.min, max: range.max)
    update_attributes(min_grade_level: min, max_grade_level: max)
  end

  def grade_level_range
    min_grade_level..max_grade_level
  end

  def question_query
    {
      difficulty: difficulty_range,
      grade_level: grade_level_range
    }
  end

  def get_questions
    find_questions.take(number_of_questions).tap do |q|
      update_attributes(number_of_questions: q.length)
    end
  end

  def find_questions
    tagged_questions.where(**question_query).take(number_of_questions)
  end

  def tagged_questions
    { subjects: subject_list, tags: tag_list }
      .delete_if { |key, value| value.empty? }
      .reduce(Question) do
        |q, (name, list)|
        q.by_tag_list(list, name: name, default: q)
      end
  end

  def found_question_count
    @found_question_count ||= find_questions.count
  end

  def is_criteria_possible?
    found_question_count >= number_of_questions
  end
end
