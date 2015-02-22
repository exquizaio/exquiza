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

class Choice < ActiveRecord::Base
  belongs_to :question, inverse_of: :choices
  belongs_to :response

  scope :answers, -> { where(answer: true) }

  def to_s
    content.to_s
  end


end
