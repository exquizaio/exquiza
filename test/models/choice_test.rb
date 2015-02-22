# == Schema Information
#
# Table name: choices
#
#  id          :integer          not null, primary key
#  content     :text
#  answer      :boolean
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  response_id :integer
#

require 'test_helper'

class ChoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
