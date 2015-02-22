# == Schema Information
#
# Table name: passages
#
#  id                 :integer          not null, primary key
#  passage_prompts_id :integer
#  author             :string
#  source             :string
#  body               :text
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class PassageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
