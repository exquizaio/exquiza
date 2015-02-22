class CreateParagraphPrompts < ActiveRecord::Migration
  def change
    create_table :paragraph_prompts do |t|
      t.text :content
      t.references :question, index: true

      t.timestamps null: false
    end
    add_foreign_key :paragraph_prompts, :questions
  end
end
