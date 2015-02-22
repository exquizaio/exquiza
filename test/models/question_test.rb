# == Schema Information
#
# Table name: questions
#
#  id           :integer          not null, primary key
#  directions   :text
#  difficulty   :integer
#  grade_level  :integer
#  prompt_id    :integer
#  prompt_type  :string
#  choices_id   :integer
#  tests_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  responses_id :integer
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
