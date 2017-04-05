$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "yellin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "yellin"
  s.version     = Yellin::VERSION
  s.authors     = ["Luke Hogan", "Michael Hartl"]
  s.email       = ["hoganld@gmail.com"]
  s.homepage    = "https://github.com/dukemagen/yellin.git"
  s.summary     = "Rails engine providing authentication based on `has_secure_password`."
  s.description = "Rails engine providing user authentication and basic account management (account confirmation, password reset); Based on authentication framework developed during Michael Hartl's Ruby on Rails Tutorial."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"
  s.add_dependency "bcrypt", "~>3.1.11"

  s.add_development_dependency "sqlite3"
  s.add_dependency "rails-controller-testing"
end
