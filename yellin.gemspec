$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "yellin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "yellin"
  s.version     = Yellin::VERSION
  s.authors     = ["Luke Hogan"]
  s.email       = ["hoganld@gmail.com"]
  s.homepage    = "https://github.com/hoganld/yellin.git"
  s.summary     = "Multi-Factor Authentication for Rails"
  s.description = "MFA for Rails supporting Passwords, TOTP, Webauthn and Passkeys"
  s.license     = "MIT"
  s.required_ruby_version = '>= 3.2'

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 7.1"
  s.add_dependency "bcrypt", "~> 3.1"

  s.add_development_dependency "sqlite3", "~> 1.4"
  # TODO remove the need for this dependency by removing test calls to `assigns`
  s.add_development_dependency "rails-controller-testing"
end
