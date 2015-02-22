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

class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :test, inverse_of: :responses
  has_one :selected_choice, class_name: "Choice"
  has_one :correct_choice, class_name: "Choice"
  has_many :choices

  scope :correct_responses, -> { where(correct: true) }
  scope :wrong_responses, -> { where(correct: false) }

end
