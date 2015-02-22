class AddResponsesToTests < ActiveRecord::Migration
  def change
    add_reference :tests, :responses
  end
end
