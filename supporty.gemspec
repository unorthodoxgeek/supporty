# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "supporty/version"

Gem::Specification.new do |s|
  s.name        = "supporty"
  s.version     = Supporty::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tom Caspy"]
  s.email       = ["tom@orthodoxgeek.co.il"]
  s.homepage    = "http://www.orthodoxgeek.co.il"
  s.summary     = %q{File editor for locales for rails` I18N annoying yml way}
  s.description = %q{Supporty is a ruby open source customer support framework}

  s.rubyforge_project = "cms"
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rspec"
  s.add_dependency "rails"
  
end
