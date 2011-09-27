require_relative "test_helper"

require "mocha"

class RulesetTest < Test::Unit::TestCase
  include TestHelper

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

  def test_empty_ruleset_creation
    ruleset = empty_ruleset
    assert_not_nil(ruleset)
    assert_equal(0, ruleset.count)
  end

  def test_simple_ruleset_creation
    ruleset = one_rule_ruleset
    assert_not_nil(ruleset)
    assert_equal(1, ruleset.count)
  end

  def test_ruleset_scoring
    RSlow::Ruleset.any_instance.stubs(:rule).returns(*mock_rules)
    fake_weights = RULE_CONFIG.map { |fake_rule| fake_rule[:weight] }
    fake_scores = RULE_CONFIG.map { |fake_rule| fake_rule[:evaluate][:score] }
    expected_score = weighted_average_of_fake_scores(fake_scores, fake_weights)

    ruleset = empty_ruleset
    mock_rules.each { |rule| ruleset << rule }

    evaluation = ruleset.evaluate(nil)
    assert_equal(expected_score, JSON.parse(evaluation)["score"])
  end
end
