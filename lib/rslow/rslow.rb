module RSlow
  extend self

  def configure(&block)
    instance_eval(&block)
  end

  def ruleset(label, &block)
    ruleset = Ruleset.new(label)
    ruleset.instance_eval(&block) if block_given?
    self.rulesets[ruleset.label] = ruleset
    ruleset
  end

  def rulesets
    @rulesets ||= {}
  end
end

