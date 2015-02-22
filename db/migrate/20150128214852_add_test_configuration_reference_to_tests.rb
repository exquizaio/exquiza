class AddTestConfigurationReferenceToTests < ActiveRecord::Migration
  def change
    add_reference :tests, :test_configuration, index: true
    add_foreign_key :tests, :test_configurations
  end
end
