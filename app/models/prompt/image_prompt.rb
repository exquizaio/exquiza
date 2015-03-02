class Prompt::ImagePrompt < ActiveRecord::Base
  include Prompt
  has_one :question, as: :prompt

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment :image, :presence => true,
  :content_type: { content_type: /\Aimage\/.*\Z/ }

  def self.params
    [:id, :image]
  end

  def to_s
    "Image"
  end
end
