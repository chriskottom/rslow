$:.push File.expand_path("../lib", __FILE__)
require "rslow/version"

Gem::Specification.new do |s|
  s.name        = "rslow"
  s.version     = RSlow::VERSION
  s.authors     = ["Chris kottom"]
  s.email       = "chris@chriskottom.com"
  s.homepage    = ""
  s.summary     = %q{A YSlow-like framework for web page evaluation in Ruby}
  s.description = %q{RSlow is a framework for defining and executing a configurable set of rules that will gauge or grade probable end user experience based on critieria like HTTP request and response parameters, page structure, number and size of requested resources, etc.}

  s.rubyforge_project = "rslow"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = ["rslow"]
  s.require_paths = ["lib", "vendor"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
