#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), "/../lib")
require "rslow"


ruleset_file = ARGV.shift
ruleset = RSlow::Ruleset.new(ruleset_file)
puts "Ruleset:  #{ ruleset.count } rules loaded from #{ ruleset_file }"

url = ARGV.shift
page = RSlow::HtmlResource.new(url)
puts "Page:     loaded from #{ page.url }"

puts
ruleset.evaluate(page)
ruleset.print_evaluation
