class Prompt::PassagePrompt < ActiveRecord::Base
  include Prompt
  has_one :question, as: :prompt
  belongs_to :passage

  accepts_nested_attributes_for :passage

  def self.params
    [:id, :content, passage_attributes: passage_params]
  end

  def self.passage_params
    [:id, :author, :title, :source, :body]
  end

  def to_s
    "[#{passage.byline}] #{content}"
  end
end
