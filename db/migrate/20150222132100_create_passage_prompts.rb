class CreatePassagePrompts < ActiveRecord::Migration
  def change
    create_table :passage_prompts do |t|
      t.references :passage
      t.text :content
      t.references :question, index: true

      t.timestamps null: false
    end
  end
end
