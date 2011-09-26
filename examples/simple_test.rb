#!/usr/bin/env ruby


# User must provide a URL to test as a command line parameter.
USAGE_MESSAGE = "Usage: example/simple_test.rb < URL TO TEST >"
Kernel.abort(USAGE_MESSAGE) unless ARGV.length == 1


require_relative "../lib/rslow"


# RSlow uses a declarative Ruby DSL for defining rulesets.
# The configuration is loaded by simply requiring the configuration file.
require_relative "./simple_config"


# Print some basic information about the ruleset.
simple_ruleset = RSlow.rulesets[:simple_ruleset]
puts "Ruleset:  #{ simple_ruleset.count } rules loaded"


# Get the URL from the command line and build the resource tree.
url = ARGV.shift
page = RSlow.page(:simple_page, url)
puts "Page:     loaded from #{ page.url }"


# Evaluate the URL page using the simple ruleset.
eval_json = RSlow.evaluate(:simple_page, :simple_ruleset)
evaluation = JSON.parse(eval_json)

puts
puts "Results:"
evaluation["rule_evaluations"].each do |rule_result|
  puts "#{ rule_result["grade"] }  " +
       "#{ rule_result["score"].to_s.rjust(3) }  " + 
       "#{ rule_result["title"] }"
end
puts "#{ evaluation["grade"] }  #{ evaluation["score"].to_s.rjust(3) }  OVERALL"
