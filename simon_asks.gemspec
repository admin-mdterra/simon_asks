$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simon_asks/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simon_asks"
  s.version     = SimonAsks::VERSION
  s.authors     = ["Andrey Eremin, Anton Volkov"]
  s.email       = ["dsoft88@gmail.com, choixer@gmail.com"]
  s.homepage    = "https://github.com/developer88/simon_asks"
  s.summary     = "Lightweight Q&A gem for Rails."
  s.description = "Lightweight Q&A gem for Ruby on Rails Applications inspired by Stackoverflow."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12"

  s.add_dependency "devise"
  s.add_dependency "cancan"

  s.add_dependency "acts-as-taggable-on"
  s.add_dependency "acts_as_votable"
  s.add_dependency "awesome_nested_set"

  s.add_dependency "carrierwave"
  s.add_dependency "fog"
  s.add_dependency "mini_magick"

  s.add_dependency "auto_html"
  #s.add_dependency "kaminari", "~> 0.14.1"
  s.add_dependency "haml"
  s.add_dependency "haml-rails"
  s.add_dependency "coffee-rails"
  s.add_dependency "twitter-bootstrap-rails"

  #s.add_dependency "activeadmin", "~> 0.5.1"

  s.add_dependency "pg"
  s.add_dependency "pg_search"
  
  # development
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.13.1"
  s.add_development_dependency "yard", "~> 0.8.6.1"
  s.add_development_dependency "factory_girl", "~> 4.2.0"
  s.add_development_dependency "shoulda", "~> 3.4.0"
  s.add_development_dependency "kaminari", "~> 0.14.1"
  s.add_development_dependency "rspec-mocks", "~> 2.13.1"
end
