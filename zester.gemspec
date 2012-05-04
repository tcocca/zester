# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "zester/version"

Gem::Specification.new do |s|
  s.name        = "zester"
  s.version     = Zester::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tom Cocca"]
  s.email       = ["tom.cocca@gmail.com"]
  s.homepage    = "http://github.com/tcocca/zester"
  s.summary     = %q{Ruby wrapper for the Zillow API}
  s.description = %q{Ruby API wrapper for Zillow API built with httparty designed for multiple keys}

  s.rubyforge_project = "zester"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'httparty', '~> 0.8.3'
  s.add_dependency "rash", "~> 0.3.2"
  s.add_development_dependency "rake", "~> 0.9.2"
  s.add_development_dependency "rspec", "~> 2.10.0"
  s.add_development_dependency "webmock", "~> 1.8.6"
  s.add_development_dependency "vcr", "~> 2.1.1"
end
