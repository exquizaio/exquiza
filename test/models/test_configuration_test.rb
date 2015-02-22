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

require 'test_helper'

class TestConfigurationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
