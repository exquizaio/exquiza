# == Schema Information
#
# Table name: prompts
#
#  id          :integer          not null, primary key
#  content     :text
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class PromptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
