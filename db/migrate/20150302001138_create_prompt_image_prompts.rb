class CreatePromptImagePrompts < ActiveRecord::Migration
  def change
    create_table :image_prompts do |t|
      t.references :question, index: true
      
      t.timestamps null: false
    end
  end
end
