require_relative "test_helper"

require "test/unit"
require "rslow"

class RulesetTest < Test::Unit::TestCase
  def empty_ruleset
    RSlow::Ruleset.new(:testing)
  end

  def one_rule_ruleset
    RSlow::Ruleset.new(:testing) do
      rule :RequestCount, 
           {
             title: "Minimize the number of HTTP requests",
             weight: 8,
             resources: { 
               script:    { max: 3, points: 4 },
               css:       { max: 2, points: 4 },
               css_image: { max: 6, points: 3 }
             }
           }
    end
  end

  def test_simple_ruleset_creation
    ruleset = empty_ruleset
    assert_not_nil(ruleset)
    assert_equal(0, ruleset.count)
  end

  def test_complex_ruleset_creation
    ruleset = one_rule_ruleset
    assert_not_nil(ruleset)
    assert_equal(1, ruleset.count)
  end

  def test_ruleset_evaluation
    ruleset = 
  end
end
