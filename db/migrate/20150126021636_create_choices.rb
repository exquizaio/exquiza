class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.text :content
      t.boolean :answer
      t.references :question, index: true

      t.timestamps null: false
    end
    add_foreign_key :choices, :questions
  end
end
