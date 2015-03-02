class AddAttachmentImageToImagePrompts < ActiveRecord::Migration
  def self.up
    change_table :image_prompts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :image_prompts, :image
  end
end
