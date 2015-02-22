# == Schema Information
#
# Table name: tests
#
#  id                    :integer          not null, primary key
#  type                  :string
#  user_id               :integer
#  started_on            :datetime
#  started               :boolean
#  finished_on           :datetime
#  finished              :boolean
#  questions_id          :integer
#  adaptive              :boolean          default("f")
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  test_configuration_id :integer
#  token                 :string
#  responses_id          :integer
#  position              :integer          default("0")
#

require 'test_helper'

class TestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
