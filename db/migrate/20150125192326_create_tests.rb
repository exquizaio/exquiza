class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string     :type
      t.references :user, index: true

      t.datetime   :started_on
      t.boolean    :started

      t.datetime   :finished_on
      t.boolean    :finished

      t.references :questions

      t.boolean    :adaptive, default: false

      t.timestamps null: false
    end
  end
end
