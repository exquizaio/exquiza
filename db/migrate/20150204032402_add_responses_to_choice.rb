class AddResponsesToChoice < ActiveRecord::Migration
  def change
    add_reference :choices, :response, index: true
    add_foreign_key :choices, :response
  end
end
