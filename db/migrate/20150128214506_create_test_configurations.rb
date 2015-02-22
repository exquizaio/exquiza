class CreateTestConfigurations < ActiveRecord::Migration
  def change
    create_table :test_configurations do |t|
      t.integer :number_of_questions
      t.integer :min_difficulty
      t.integer :max_difficulty
      t.integer :min_grade_level
      t.integer :max_grade_level
      t.references :test

      t.timestamps null: false
    end
  end
end
