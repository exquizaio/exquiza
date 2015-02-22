class CreatePassages < ActiveRecord::Migration
  def change
    create_table :passages do |t|
      t.references :passage_prompts
      t.string :author
      t.string :source
      t.text :body
      t.string :title

      t.timestamps null: false
    end
  end
end
