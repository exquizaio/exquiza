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

class Test < ActiveRecord::Base
  include SecureToken
  has_secure_token
  belongs_to :user, inverse_of: :tests
  has_and_belongs_to_many :questions
  has_many :responses
  has_one :test_configuration

  accepts_nested_attributes_for :test_configuration
  
  validates_with CriteriaPossibleValidator

  def start!
    update_attributes(started: true, started_on: Time.now, position: 1)
    generate_questions
  end

  def complete!
    update_attributes(finished: true, finished_on: Time.now)
  end

  def new_response(question, response_params)
    a_response = responses.create!(selected_choice: Choice.where(id: response_params["selected_choice_id"]).first, question: question)
    scored_response = question.score(a_response.selected_choice, question.choices)
    a_response.update_attributes(choices: question.choices, correct: a_response.selected_choice.answer?)
  end

  def can_show_response?(question)
    responses.find(question_id: question.id) and test.finished?
  end

  def generate_questions
    update_attributes(questions: test_configuration.get_questions)
  end

  def next_question
    update_attributes(position: position + 1)
    position
  end

  def percent_correct
    (responses.correct_responses.count.to_f / questions.count.to_f) * 100
  end

end
