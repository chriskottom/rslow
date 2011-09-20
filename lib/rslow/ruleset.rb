require "delegate"

module RSlow
  class Ruleset < DelegateClass(Array)
    attr_reader :label

    def initialize(label="", &block)
      @label = label
      super([])
      instance_eval(&block) if block_given?
    end

    def rule(type, options={})
      self << Rule.generate(type, options)
    end

    def evaluate(resource)
      rule_evaluations = self.map { |rule| rule.evaluate(resource) }
      rule_evaluations.to_json
    end

  end
end
