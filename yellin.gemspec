$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "yellin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "yellin"
  s.version     = Yellin::VERSION
  s.authors     = ["Luke Hogan", "Michael Hartl"]
  s.email       = ["hoganld@gmail.com"]
  s.homepage    = "https://github.com/hoganld/yellin.git"
  s.summary     = "Minimalistic Rails engine providing user authentication."
  s.description = "Minimalistic Rails engine providing user registration, authentication, and password reset."
  s.license     = "MIT"
  s.required_ruby_version = '>= 2.2.2'

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0"
  s.add_dependency "bcrypt", "~> 3.1"

  s.add_development_dependency "sqlite3", "~> 1.4"
  s.add_development_dependency "rails-controller-testing"
end
