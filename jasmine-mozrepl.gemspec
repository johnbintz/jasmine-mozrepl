# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jasmine-mozrepl/version"

Gem::Specification.new do |s|
  s.name        = "jasmine-mozrepl"
  s.version     = Jasmine::MozRepl::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["John Bintz"]
  s.email       = ["john@coswellproductions.com"]
  s.homepage    = ""
  s.summary     = %q{Watch a Jasmine test suite in Firefox}
  s.description = %q{Using MozRepl, watch and get success/failure information from a Jasmine test suite}

  s.rubyforge_project = "jasmine-mozrepl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rainbow'
end
