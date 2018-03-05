module Calib
  module Controllers
    autoload :BasicAuth, 'calib/controllers/basic_auth'
  end
  
  module Devise
    autoload :SoftDeletionMigrationEnhancable, 'calib/devise/soft_deletion_migration_enhancable'
    autoload :SoftDeletion, 'calib/devise/soft_deletion'
  end  

  module Pundit
    autoload :ControllerNestable, 'calib/pundit/controller_nestable'
    autoload :Nestable, 'nestable'
  end

  module SoftDeletion
    autoload :MigrationEnhancable, 'calib/soft_deletion/migration_enhancable'
  end

  autoload :Delegatable, 'calib/delegatable'
  autoload :IllegalAccessError, 'calib/illegal_access_error'
  autoload :Service, 'calib/service'
  autoload :UnauthenticatedError, 'calib/unauthenticated_error'
end
