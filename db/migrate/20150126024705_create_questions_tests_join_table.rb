class CreateQuestionsTestsJoinTable < ActiveRecord::Migration
  def change
    create_table :questions_tests do |t|
      t.references :question
      t.references :test
    end
  end
end
