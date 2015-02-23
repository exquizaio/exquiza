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

class Passage < ActiveRecord::Base
  has_many :passage_prompts, class_name: "Prompt::PassagePrompt"

  val

  def byline
    title.titlecase + ", by " + author.titlecase
  end

end
