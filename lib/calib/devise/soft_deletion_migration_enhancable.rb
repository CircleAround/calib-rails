# == A Module for migration with soft deletation 
# 1. unique email to ununique
# 2. email and _filter_column_ to composite unique 
# 3. add colunn _caneled_at_column_ for storing canceled datetime
#
# === usage
# create migration file
#
#  class ChangeForSoftDeletationToUsers < ActiveRecord::Migration[5.1]
#    include Calib::Devise::SoftDeletionMigrationEnhancable
#    def change
#      change_for_device_soft_deletion(:users)
#    end
#  end
#
# do migration
#
# and results on schema.rb:
#
#  # with coulumn for soft_deleted_flag
#  t.integer "alive", default: 1
#
#  # unique indexes
#  # [for postgresql] - partial indexes -
#  t.index ["email", "alive"], name: "index_users_on_email_and_alive", unique: true, where: "(alive = 1)"
#  # [for mysql] - ignoring null column -
#  t.index ["email", "alive"], name: "index_users_on_email_and_alive", unique: true
module Calib::Devise::SoftDeletionMigrationEnhancable
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