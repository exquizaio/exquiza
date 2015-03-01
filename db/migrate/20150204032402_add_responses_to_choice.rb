class AddResponsesToChoice < ActiveRecord::Migration
  def change
    add_reference :choices, :response
  end
end
