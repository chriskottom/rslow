#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), "/../lib")
require "rslow"
require "yaml"


ruleset_file = ARGV.shift
rule_config = YAML.load_file(ruleset_file)

ruleset = RSlow::Ruleset.new(:simple) do
  rule :RequestCount, rule_config.first["rule_params"]
end

#ruleset = RSlow::Ruleset.new(ruleset_file)
puts "Ruleset:  #{ ruleset.count } rules loaded from #{ ruleset_file }"

url = ARGV.shift
page = RSlow::HtmlResource.new(url)
puts "Page:     loaded from #{ page.url }"

puts
ruleset.evaluate(page)
ruleset.print_evaluation
