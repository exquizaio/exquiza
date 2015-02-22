class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text        :directions
      t.integer     :difficulty
      t.integer     :grade_level
      t.references  :prompt, polymorphic: true
      t.references  :choices
      t.references  :tests
      t.timestamps null: false
    end
  end
end
