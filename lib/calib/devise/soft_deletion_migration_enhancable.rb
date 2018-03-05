module Calib::Devise::SoftDeletionMigrationEnhancable
  include ActiveSupport::Concern
  include Calib::SoftDeletion::MigrationEnhancable

  def change_for_device_soft_deletion(scope, filter_column = :alive, canceled_at_column = :canceled_at)
    reversible do |dir|
      dir.up { remove_index scope, :email }
      dir.down { add_index scope, :email, unique: true }
    end

    add_column scope, canceled_at_column, :datetime

    add_column_for_soft_deletion(scope, filter_column)
    add_unique_index_for_soft_deletion(scope, :email, filter_column)
  end
end