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

class Question < ActiveRecord::Base
  acts_as_taggable_on :tags, :subjects
  has_and_belongs_to_many :tests
  has_many :choices, inverse_of: :question
  belongs_to  :prompt, polymorphic: true
  has_many :responses

  accepts_nested_attributes_for :prompt, allow_destroy: true
  accepts_nested_attributes_for :choices, allow_destroy: true

  validates_presence_of :tag_list, :subject_list
  validates :difficulty,
    inclusion: { within: 0..100, message: "must be between 0 and 100" },
    presence: true
  validates :grade_level,
    inclusion: { within: 0..12, message: "must be within 0 to 12" },
    presence: true

  def answer
    choices.find(:correct?)
  end

  def build_prompt(params)
    type = params.delete(:type_name)
    self.prompt = Prompt.for(type).new(params)
  end

  def score(selected_choice, some_choices)
    correct_choice = some_choices.answers.first
    #puts "A: " + correct_choice.id.inspect
    #puts "B: " + selected_choice.id.inspect
    #(selected_choice.id == correct_choice.id)
  end

end
