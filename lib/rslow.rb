$:.unshift(File.dirname(__FILE__))

require "rslow/rslow"

require "rslow/resource"
require "rslow/resources/basic_resource"
require "rslow/resources/html_resource"
require "rslow/resources/css_resource"
require "rslow/resources/js_resource"

require "rslow/ruleset"
require "rslow/rule"
require "rslow/rules/request_count_rule"
require "rslow/grading"
