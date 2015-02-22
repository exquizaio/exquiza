# == Schema Information
#
# Table name: responses
#
#  id                 :integer          not null, primary key
#  question_id        :integer
#  selected_choice_id :integer
#  correct_choice_id  :integer
#  choices_id         :integer
#  test_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  correct            :boolean
#

require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
