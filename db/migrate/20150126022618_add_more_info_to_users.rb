class AddMoreInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :grade, :integer
    add_column :users, :school, :string
    add_reference :users, :tests
  end
end
