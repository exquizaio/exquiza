# == Schema Information
#
# Table name: paragraph_prompts
#
#  id          :integer          not null, primary key
#  content     :text
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Prompt::ParagraphPrompt < ActiveRecord::Base
  include Prompt
  has_one :question, as: :prompt

  def self.params
    [:id, :content]
  end

  def to_s
    content.to_s
  end
end
