class CreateKatexPrompts < ActiveRecord::Migration
  def change
    create_table :katex_prompts do |t|
      t.text :content
      t.references :question, index: true

      t.timestamps null: false
    end
    add_foreign_key :katex_prompts, :questions
  end
end
