require_relative "test_helper"


class RuleTest < Test::Unit::TestCase

  # RSlow::Rule.generate should allow creation of concrete rule instances.
  def test_known_rule_creation_by_full_name
    rule_type = :RequestCountRule
    rule = RSlow::Rule.generate(rule_type)
    assert_instance_of(RSlow::Rules::RequestCountRule, rule)
  end

  # Short rule names should also work - e.g. RequestCountRule => RequestCount
  def test_known_rule_creation_by_shortened_name
    rule_type = :RequestCount
    rule = RSlow::Rule.generate(rule_type)
    assert_instance_of(RSlow::Rules::RequestCountRule, rule)
  end

  # Unknown rule classes should raise a NameError.
  def test_unknown_rule_creation
    rule_type = :NoSuchThingRule
    assert_raises(NameError) { RSlow::Rule.generate(rule_type) }
  end

end
