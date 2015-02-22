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

  def build_query
    {
      difficulty: difficulty_range,
      grade_level: grade_level_range
    }
  end

  def build_questions

    Question.all.shuffle.first(number_of_questions)
  end

  def with_tags
    tagged_with(subject_list, on: :subjects, any: true).tagged_with(tag_list, on: :tags, any: true)
  end

end
