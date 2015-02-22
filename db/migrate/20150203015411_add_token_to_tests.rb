class AddTokenToTests < ActiveRecord::Migration
  def change
    add_column :tests, :token, :string
    add_index :tests, :token, unique: true
  end
end
