$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "husky/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "husky"
  s.version     = Husky::VERSION
  s.authors     = ["Stephen Fiser"]
  s.email       = ["stephen.fiser@gmail.com"]
  s.homepage    = "http://www.huskyrb.com"
  s.summary     = "For when your app starts to get a little big."
  s.description = "Husky is a tool to help you grow your Rails app."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "after_do", '0.3.1'
end
