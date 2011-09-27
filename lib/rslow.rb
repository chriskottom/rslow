$:.unshift(File.dirname(__FILE__))

require "rslow/rslow"

require "rslow/ruleset"
require "rslow/grading"

require "rslow/rule"
require "rslow/rules/request_count_rule"
require "rslow/rules/gzip_rule"
require "rslow/rules/dom_elements_rule"
require "rslow/rules/url_redirect_rule"

require "rslow/resource"
require "rslow/resources/basic_resource"
require "rslow/resources/html_resource"
require "rslow/resources/css_resource"
require "rslow/resources/js_resource"
