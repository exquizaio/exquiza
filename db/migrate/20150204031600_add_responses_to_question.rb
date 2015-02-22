class AddResponsesToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :responses
  end
end
