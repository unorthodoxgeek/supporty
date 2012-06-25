# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "supporty/version"

Gem::Specification.new do |s|
  s.name        = "supporty"
  s.version     = Supporty::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tom Caspy"]
  s.email       = ["tom@orthodoxgeek.co.il"]
  s.homepage    = "http://un.orthodoxgeek.co.il"
  s.summary     = %q{Supporty is a ruby open source customer support framework}
  s.description = %q{Supporty is a ruby open source customer support framework}

  s.rubyforge_project = "cms"
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl"
  s.add_development_dependency "spork"
  s.add_development_dependency "mysql2"
  s.add_development_dependency "faker"
  s.add_development_dependency "devise"
  s.add_dependency "rails"
  s.add_dependency "rakismet"
  
end
