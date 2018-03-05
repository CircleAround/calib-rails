lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Maintain your gem's version:
require "calib/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "calib-rails"
  s.version     = Calib::Rails::VERSION
  s.authors     = ["ms2sato"]
  s.email       = ["ms2.sato@gmail.com"]
  s.homepage    = "https://github.com/CircleAround/calib"
  s.summary     = "Calib is Foundation library by CIRCLE AROUND Inc."
  s.description = "Calib is Foundation library by CIRCLE AROUND Inc."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 5.1.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
