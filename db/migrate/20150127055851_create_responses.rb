class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :question
      t.references :selected_choice
      t.references :correct_choice
      t.references :choices
      t.references :test

      t.timestamps null: false
    end
  end
end
